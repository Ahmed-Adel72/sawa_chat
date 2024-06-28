import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa_chat/core/routing/app_router.dart';
import 'package:sawa_chat/core/routing/routes.dart';

class SawaApp extends StatelessWidget {
  final AppRouter appRouter;
  const SawaApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'sawa app',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: Colors.white,
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: Colors.black,
        ),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.loginScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
