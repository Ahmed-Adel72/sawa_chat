import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa_chat/core/constants/app_constants.dart';
import 'package:sawa_chat/core/helpers/cache_helper.dart';
import 'package:sawa_chat/core/helpers/toast_helper.dart';
import 'package:sawa_chat/core/routing/routes.dart';
import 'package:sawa_chat/features/login/data/repos/login_repo.dart';
import 'package:sawa_chat/features/login/logic/cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(InitialLoginState());
  static LoginCubit get(context) => BlocProvider.of(context);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoginLoading = false;
  Future<void> userLogin({required context}) async {
    emit(UserLoginLoadingState());
    isLoginLoading = true;
    try {
      final results = await _loginRepo.userSignIn(
          emailController.text, passwordController.text);
      uId = results.user!.uid;
      CacheHelper.setData(key: 'uId', value: uId);
      ToastHelper.showSuccessToast(message: 'Login Successful');
      emit(UserLoginSuccessState());
      isLoginLoading = false;
      Navigator.pushReplacementNamed(context, Routes.layoutScreen);
    } catch (error) {
      isLoginLoading = false;
      ToastHelper.showErrorToast(message: "$error");
      emit(UserLoginErrorState());
    }
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
