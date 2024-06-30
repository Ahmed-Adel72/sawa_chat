import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sawa_chat/core/helpers/extensions.dart';
import 'package:sawa_chat/core/routing/routes.dart';
import 'package:sawa_chat/core/theming/app_text_styles.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Already have an acount?',
            style: AppTextStyles.font18GrayBold,
          ),
          TextSpan(
              text: ' Login',
              style: AppTextStyles.font18MainOrangeBold,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.pushReplacementNamed(Routes.loginScreen);
                }),
        ],
      ),
    );
  }
}
