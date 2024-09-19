import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa_chat/core/helpers/toast_helper.dart';
import 'package:sawa_chat/core/routing/routes.dart';
import 'package:sawa_chat/features/sign_up/data/models/user_model.dart';
import 'package:sawa_chat/features/sign_up/data/repos/sign_up_repo.dart';
import 'package:sawa_chat/features/sign_up/logic/cubit/sign_up_states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  final SignUpRepo signUpRepo;
  SignUpCubit(this.signUpRepo) : super(InitialSignUpState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoadingSignUp = false;
  Future<void> userSignUp({required context}) async {
    emit(UserSignUpLoadingState());
    isLoadingSignUp = true;

    try {
      UserCredential value = await signUpRepo.signUpWithEmailAndPassword(
          emailController.text, passwordController.text);

      // After signup, create user in fireStore
      UserModel userModel = UserModel(
        name: nameController.text,
        email: emailController.text,
        uId: value.user!.uid,
        bio: 'Hey there! i\'m using sawa chat',
        image:
            'https://as2.ftcdn.net/v2/jpg/05/89/93/27/500_F_589932782_vQAEAZhHnq1QCGu5ikwrYaQD0Mmurm0N.jpg',
        isTyping: false,
        lastMessage: '',
        timestamp: DateTime.now(),
        senderId: '',
        pushToken: '',
      );
      await signUpRepo.createUserInFireStore(userModel).then((value) {
        ToastHelper.showSuccessToast(
            message: 'Signup Successfully, Please login');

        Navigator.pushReplacementNamed(context, Routes.loginScreen);
      });

      emit(UserSignUpSuccessState());
      isLoadingSignUp = false;
    } catch (error) {
      ToastHelper.showErrorToast(message: "$error");
      emit(UserSignUpErrorState());
      isLoadingSignUp = false;
    }
  }

  bool isPasswordObsecure = true;
  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisibilitySignUp() {
    isPasswordObsecure = !isPasswordObsecure;
    isPasswordObsecure
        ? suffix = Icons.visibility_outlined
        : suffix = Icons.visibility_off_outlined;
    emit(ChangePasswordVisibility());
  }
}
