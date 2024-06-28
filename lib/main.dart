import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sawa_chat/core/routing/app_router.dart';
import 'sawa_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyBUMcCzUpHEKcOaP1nb73qzgpz0zPmNiWo',
    projectId: 'sawa-chat-30e8c',
    storageBucket: 'sawa-chat-30e8c.appspot.com',
    appId: 'com.example.sawa_chat',
    messagingSenderId: '1:439685552158:android:e3368933b633e99148760f',
  ));
  await ScreenUtil.ensureScreenSize();
  runApp(SawaApp(
    appRouter: AppRouter(),
  ));
}
