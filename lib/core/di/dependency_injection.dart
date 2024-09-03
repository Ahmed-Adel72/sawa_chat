import 'package:get_it/get_it.dart';
import 'package:sawa_chat/features/chat/data/repos/chat_repo.dart';
import 'package:sawa_chat/features/chat/logic/cubit/chat_cubit.dart';
import 'package:sawa_chat/features/layout/data/repos/layout_repo.dart';
import 'package:sawa_chat/features/layout/logic/cubit/layout_cubit.dart';
import 'package:sawa_chat/features/login/data/repos/login_repo.dart';
import 'package:sawa_chat/features/login/logic/cubit/login_cubit.dart';
import 'package:sawa_chat/features/sign_up/data/repos/firebase_signup_repo.dart';
import 'package:sawa_chat/features/sign_up/data/repos/sign_up_repo.dart';
import 'package:sawa_chat/features/sign_up/logic/cubit/sign_up_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo());
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  // signup
  getIt.registerLazySingleton<SignUpRepo>(() => FirebaseSignUpRepo());
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));

  // layout
  getIt.registerLazySingleton<LayoutRepo>(() => LayoutRepo());
  getIt.registerFactory<LayoutCubit>(() => LayoutCubit(getIt()));

  // chat
  getIt.registerLazySingleton<ChatRepo>(() => ChatRepo());
  getIt.registerFactory<ChatCubit>(() => ChatCubit(getIt()));
}
