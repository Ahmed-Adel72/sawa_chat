import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sawa_chat/core/routing/app_router.dart';
import 'package:sawa_chat/core/routing/routes.dart';
import 'package:sawa_chat/core/theming/app_colors.dart';
import 'package:sawa_chat/main.dart';

class SawaApp extends StatelessWidget {
  final AppRouter appRouter;
  SawaApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'sawa app',
        theme: ThemeData(
            primarySwatch: Colors.orange,
            scaffoldBackgroundColor: AppColors.moreLightGray,
            appBarTheme:
                const AppBarTheme(backgroundColor: AppColors.moreLightGray)),
        darkTheme: ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: Colors.black,
        ),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
