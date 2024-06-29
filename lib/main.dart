import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sawa_chat/core/routing/app_router.dart';
import 'sawa_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  runApp(SawaApp(
    appRouter: AppRouter(),
  ));
}
