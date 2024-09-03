import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sawa_chat/features/sign_up/data/models/user_model.dart';

class LayoutRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user data
  Future<UserModel?> getUserData({required String uId}) async {
    try {
      final results = await _firestore.collection('users').doc(uId).get();
      if (results.exists) {
        return UserModel.fromJson(results.data()!);
      }
    } catch (error) {
      print("error getting user data: $error");
    }
    return null;
  }
}
