import 'package:get_it/get_it.dart';
import 'package:sawa_chat/features/sign_up/data/repos/firebase_signup_repo.dart';
import 'package:sawa_chat/features/sign_up/data/repos/sign_up_repo.dart';
import 'package:sawa_chat/features/sign_up/logic/cubit/sign_up_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // signup
  getIt.registerLazySingleton<SignUpRepo>(() => FirebaseSignUpRepo());
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));
}
