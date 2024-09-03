import 'package:firebase_auth/firebase_auth.dart';

class LoginRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> userSignIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }
}
