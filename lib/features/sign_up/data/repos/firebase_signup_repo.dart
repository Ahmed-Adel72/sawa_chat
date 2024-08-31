import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sawa_chat/features/sign_up/data/models/user_model.dart';
import 'package:sawa_chat/features/sign_up/data/repos/sign_up_repo.dart';

class FirebaseSignUpRepo implements SignUpRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createUserInFireStore(UserModel user) async {
    return await _firestore.collection('users').doc(user.uId).set(user.toMap());
  }

  @override
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
