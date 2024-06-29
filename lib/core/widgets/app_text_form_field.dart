import 'package:flutter/material.dart';
import 'package:sawa_chat/core/theming/app_colors.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final InputBorder? focusBorder;
  final InputBorder? enableBorder;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Icon? prefixIcon;
  final Function(String?) validator;
  const AppTextFormField({
    super.key,
    this.controller,
    required this.hintText,
    required this.validator,
    this.isObscureText,
    this.focusBorder,
    this.enableBorder,
    this.suffixIcon,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: AppColors.moreLightGray,
        hintText: hintText,
        isDense: true,
        focusedBorder: focusBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.mainOrange,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
        enabledBorder: enableBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.gray,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      validator: (value) {
        return validator(value);
      },
    );
  }
}
