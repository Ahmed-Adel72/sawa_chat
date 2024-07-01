import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa_chat/core/routing/routes.dart';
import 'package:sawa_chat/features/home/ui/home_screen.dart';
import 'package:sawa_chat/features/login/ui/login_screen.dart';
import 'package:sawa_chat/features/sign_up/logic/cubit/sign_up_cubit.dart';
import 'package:sawa_chat/features/sign_up/ui/sign_up_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => SignUpCubit(),
                  child: const SignUpScreen(),
                ));
      default:
        return null;
    }
  }
}
