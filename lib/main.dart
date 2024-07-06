import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa_chat/core/constants/app_constants.dart';
import 'package:sawa_chat/core/helpers/cache_helper.dart';
import 'package:sawa_chat/core/routing/app_router.dart';
import 'package:sawa_chat/core/routing/routes.dart';
import 'features/bloc/bloc_observer.dart';
import 'sawa_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

late String initialRoute;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  uId = CacheHelper.getData(key: 'uId');
  if (uId.isNotEmpty) {
    initialRoute = Routes.layoutScreen;
  } else {
    initialRoute = Routes.loginScreen;
  }

  runApp(SawaApp(
    appRouter: AppRouter(),
  ));
}
