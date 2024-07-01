import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa_chat/core/widgets/app_text_form_field.dart';
import 'package:sawa_chat/features/sign_up/logic/cubit/sign_up_cubit.dart';

// ignore: must_be_immutable
class SignUpForm extends StatelessWidget {
  SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = SignUpCubit.get(context);

    return Column(
      children: [
        Container(
          height: 220.h,
        ),
        AppTextFormField(
          controller: cubit.nameController,
          hintText: "Your name",
          isObscureText: false,
          prefixIcon: const Icon(Icons.person_outlined),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
          },
        ),
        SizedBox(
          height: 28.h,
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
          isObscureText: cubit.isPasswordObsecure,
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            onPressed: () {
              cubit.changePasswordVisibilitySignUp();
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
