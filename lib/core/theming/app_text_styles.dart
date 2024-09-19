import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sawa_chat/core/theming/app_colors.dart';
import 'package:sawa_chat/core/theming/app_font_weight.dart';

class AppTextStyles {
  static TextStyle font30DarkGrayBold = GoogleFonts.poppins(
    fontSize: 30.sp,
    fontWeight: AppFontWeight.bold,
    color: AppColors.darkgray,
  );
  static TextStyle font18DarkGrayBold = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: AppFontWeight.bold,
    color: AppColors.darkgray,
  );
  static TextStyle font18DarkGrayRegular = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: AppFontWeight.regular,
    color: AppColors.darkgray,
  );
  static TextStyle font12DarkGrayBold = GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: AppFontWeight.bold,
    color: AppColors.darkgray,
  );
  static TextStyle font12MainOrangeBold = GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: AppFontWeight.bold,
    color: AppColors.mainOrange,
  );
  static TextStyle font22MoreLightGrayBold = GoogleFonts.poppins(
    fontSize: 22.sp,
    fontWeight: AppFontWeight.bold,
    color: AppColors.moreLightGray,
  );
  static TextStyle font18MoreLightGrayBold = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: AppFontWeight.medium,
    color: AppColors.moreLightGray,
  );
  static TextStyle font18GrayBold = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: AppFontWeight.bold,
    color: AppColors.gray,
  );
  static TextStyle font18MainOrangeBold = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: AppFontWeight.bold,
    color: AppColors.mainOrange,
  );
}
