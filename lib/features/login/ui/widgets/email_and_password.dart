import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa_chat/core/widgets/app_text_form_field.dart';
import 'package:sawa_chat/features/login/logic/cubit/login_cubit.dart';

// ignore: must_be_immutable
class EmailAndPassword extends StatelessWidget {
  EmailAndPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit.get(context);
    return Column(
      children: [
        Container(
          height: 280.h,
        ),
        AppTextFormField(
          controller: cubit.emailController,
          hintText: "Email",
          isObscureText: false,
          prefixIcon: const Icon(Icons.email_outlined),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a vaild email';
            }
          },
        ),
        SizedBox(
          height: 28.h,
        ),
        AppTextFormField(
          controller: cubit.passwordController,
          hintText: "Password",
          isObscureText: cubit.isPasswordObscure,
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            onPressed: () {
              cubit.changePasswordVisibility();
            },
            icon: Icon(
              cubit.suffix,
              size: 22,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a vaild password';
            }
          },
        ),
        SizedBox(
          height: 28.h,
        ),
      ],
    );
  }
}
