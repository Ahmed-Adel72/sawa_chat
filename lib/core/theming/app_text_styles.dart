import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa_chat/core/theming/app_colors.dart';
import 'package:sawa_chat/core/theming/app_font_weight.dart';

class AppTextStyles {
  static TextStyle font30DarkGrayBold = TextStyle(
    fontSize: 30.sp,
    fontWeight: AppFontWeight.bold,
    color: AppColors.darkgray,
  );
  static TextStyle font18DarkGrayBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: AppFontWeight.regular,
    color: AppColors.darkgray,
  );
  static TextStyle font22MoreLightGrayBold = TextStyle(
    fontSize: 22.sp,
    fontWeight: AppFontWeight.bold,
    color: AppColors.moreLightGray,
  );
  static TextStyle font18GrayBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: AppFontWeight.bold,
    color: AppColors.gray,
  );
  static TextStyle font18MainOrangeBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: AppFontWeight.bold,
    color: AppColors.mainOrange,
  );
}
