import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa_chat/core/theming/app_colors.dart';

class AppTextButton extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final double? borderRadius;
  final TextStyle? textStyle;
  final Color? color;
  const AppTextButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.height,
    this.width,
    this.borderRadius,
    this.textStyle,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60.h,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 25),
        color: color ?? AppColors.mainOrange,
      ),
      child: MaterialButton(
        onPressed: onPressed!,
        child: Text(
          buttonText!,
          style: textStyle,
        ),
      ),
    );
  }
}
