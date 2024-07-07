import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa_chat/core/routing/routes.dart';
import 'package:sawa_chat/features/chat/ui/chat_screen.dart';
import 'package:sawa_chat/features/layout/logic/cubit/layout_cubit.dart';
import 'package:sawa_chat/features/layout/ui/layout_screen.dart';
import 'package:sawa_chat/features/login/logic/cubit/login_cubit.dart';
import 'package:sawa_chat/features/login/ui/login_screen.dart';
import 'package:sawa_chat/features/profile/ui/profile_screen.dart';
import 'package:sawa_chat/features/sign_up/logic/cubit/sign_up_cubit.dart';
import 'package:sawa_chat/features/sign_up/ui/sign_up_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.layoutScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LayoutCubit()
                    ..getAllUsers()
                    ..getMyData(),
                  child: const LayoutScreen(),
                ));
      case Routes.profileScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LayoutCubit()..getMyData(),
                  child: const ProfileScreen(),
                ));
      case Routes.chatScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LayoutCubit(),
                  child: const ChatScreen(),
                ));
      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LoginCubit(),
                  child: LoginScreen(),
                ));
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
