import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa_chat/core/widgets/app_text_form_field.dart';

// ignore: must_be_immutable
class EmailAndPassword extends StatelessWidget {
  EmailAndPassword({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 280.h,
        ),
        AppTextFormField(
          controller: emailController,
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
          controller: passwordController,
          hintText: "Password",
          isObscureText: true,
          prefixIcon: const Icon(Icons.lock_outline),
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
