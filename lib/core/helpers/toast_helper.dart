import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sawa_chat/core/theming/app_colors.dart';

class ToastHelper {
  // Success Toast
  static void showSuccessToast({
    required String message,
  }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.lightGray,
        timeInSecForIosWeb: 5,
        textColor: Colors.black);
  }

  // Error Toast
  static void showErrorToast({
    required String message,
  }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        timeInSecForIosWeb: 5,
        textColor: AppColors.lightGray);
  }
}
