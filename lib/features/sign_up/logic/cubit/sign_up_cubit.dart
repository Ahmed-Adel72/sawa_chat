import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sawa_chat/core/routing/routes.dart';
import 'package:sawa_chat/core/theming/app_colors.dart';
import 'package:sawa_chat/features/home/ui/home_screen.dart';
import 'package:sawa_chat/features/sign_up/data/models/user_model.dart';
import 'package:sawa_chat/features/sign_up/logic/cubit/sign_up_states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(InitialSignUpState());
  static SignUpCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoadingSignUp = false;
  void userSignUp({required context}) {
    emit(UserSignUpLoadingState());
    isLoadingSignUp = true;
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .then((value) {
      emit(UserSignUpSuccessState());
      isLoadingSignUp = false;
      userCreate(
        name: nameController.text,
        email: emailController.text,
        uId: value.user!.uid,
        context: context,
      );
      print(value);
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: '$onError',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.lightGray,
          timeInSecForIosWeb: 5,
          textColor: Colors.black);
      emit(UserSignUpErrorState());
      isLoadingSignUp = false;
      print('the errrrrror is$onError');
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String uId,
    required context,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      uId: uId,
      bio: 'Hey htere! i\'m using sawa chat',
      image: '',
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      Fluttertoast.showToast(
              msg: 'signup Successful',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: AppColors.lightGray,
              timeInSecForIosWeb: 5,
              textColor: Colors.black)
          .then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false);
      });

      emit(UserCreateSuccessState());
    }).catchError((error) {
      emit(UserCreateErrorState());
      print('errrror is$error');
    });
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
