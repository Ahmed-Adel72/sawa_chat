import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sawa_chat/core/constants/app_constants.dart';
import 'package:sawa_chat/core/helpers/cache_helper.dart';
import 'package:sawa_chat/core/routing/routes.dart';
import 'package:sawa_chat/core/theming/app_colors.dart';
import 'package:sawa_chat/features/login/logic/cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialLoginState());
  static LoginCubit get(context) => BlocProvider.of(context);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoginLoading = false;
  Future<void> userLogin({required context}) async {
    emit(UserLoginLoadingState());
    isLoginLoading = true;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .then((value) {
      uId = value.user!.uid;
      CacheHelper.setData(key: 'uId', value: uId);
      print('this is useeeeeeeeeer   $uId');
      Fluttertoast.showToast(
              msg: 'Login Successful',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: AppColors.lightGray,
              timeInSecForIosWeb: 5,
              textColor: Colors.black)
          .then((value) {
        isLoginLoading = false;
        Navigator.pushReplacementNamed(context, Routes.layoutScreen);
      });
      emit(UserLoginSuccessState());
    }).catchError((error) {
      isLoginLoading = false;
      Fluttertoast.showToast(
          msg: '$error',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.lightGray,
          timeInSecForIosWeb: 5,
          textColor: Colors.black);
      emit(UserLoginErrorState());
    });
  }

  bool isPasswordObscure = true;
  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisibility() {
    isPasswordObscure = !isPasswordObscure;
    isPasswordObscure
        ? suffix = Icons.visibility_outlined
        : suffix = Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}
