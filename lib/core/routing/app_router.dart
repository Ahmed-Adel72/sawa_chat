import 'package:flutter/material.dart';
import 'package:sawa_chat/core/routing/routes.dart';
import 'package:sawa_chat/features/login/ui/login_screen.dart';
import 'package:sawa_chat/features/sign_up/ui/sign_up_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      default:
        return null;
    }
  }
}
