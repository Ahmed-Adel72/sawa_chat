import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa_chat/core/theming/app_text_styles.dart';
import 'package:sawa_chat/core/widgets/app_text_button.dart';
import 'package:sawa_chat/features/login/ui/widgets/dont_have_account.dart';
import 'package:sawa_chat/features/sign_up/ui/widgets/already_have_account.dart';
import 'package:sawa_chat/features/sign_up/ui/widgets/sign_up_form.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/register.png"),
        fit: BoxFit.fill,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SignUpForm(),
                AppTextButton(
                  buttonText: 'Sign Up',
                  onPressed: () {},
                  textStyle: AppTextStyles.font22MoreLightGrayBold,
                ),
                SizedBox(
                  height: 15.h,
                ),
                const AlreadyHaveAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
