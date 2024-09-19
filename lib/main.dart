import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sawa_chat/core/constants/app_constants.dart';
import 'package:sawa_chat/core/di/dependency_injection.dart';
import 'package:sawa_chat/core/helpers/cache_helper.dart';
import 'package:sawa_chat/core/routing/app_router.dart';
import 'package:sawa_chat/core/routing/routes.dart';
import 'package:sawa_chat/features/notification/notification.dart';
import 'features/bloc/bloc_observer.dart';
import 'sawa_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

late String initialRoute;
void main() async {
  setupGetIt();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  uId = CacheHelper.getData(key: 'uId') ?? '';
  if (uId.isNotEmpty && uId != null) {
    initialRoute = Routes.layoutScreen;
  } else {
    initialRoute = Routes.loginScreen;
  }

  runApp(SawaApp(
    appRouter: AppRouter(),
  ));

  // Initialize Flutter Local Notifications Plugin
  FirebaseAuthService.flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await FirebaseAuthService.initializeFlutterLocalNotifications(
      FirebaseAuthService.flutterLocalNotificationsPlugin);

  // Register background message handler
  FirebaseMessaging.onBackgroundMessage(
      FirebaseAuthService.firebaseMessagingBackgroundHandler);

  // Fetch FCM Token
  await FirebaseAuthService.getFirebaseMessagingToken();

  // Start listening to Firebase messages
  FirebaseAuthService.listenToFirebaseMessages();
}
