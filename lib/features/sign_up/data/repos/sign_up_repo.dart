import 'package:firebase_auth/firebase_auth.dart';
import 'package:sawa_chat/features/sign_up/data/models/user_model.dart';

abstract class SignUpRepo {
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password);
  Future<void> createUserInFireStore(UserModel user);
}
