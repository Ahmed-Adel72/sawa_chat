import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sawa_chat/features/chat/data/models/message_model.dart';
import 'package:sawa_chat/features/sign_up/data/models/user_model.dart';

class ChatRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user data
  Future<UserModel?> getUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
    } catch (error) {
      print("Error getting user data: $error");
    }
    return null;
  }

  //send message
  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required MessageModel messageModel,
    required String message,
  }) async {
    try {
      // Send message to my chats
      await FirebaseFirestore.instance
          .collection('users')
          .doc(senderId)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .add(messageModel.toMap());

      // Update last message in my chat list
      await FirebaseFirestore.instance
          .collection('users')
          .doc(senderId)
          .collection('chats')
          .doc(receiverId)
          .set({
        'lastMessage': message,
        'timestamp': FieldValue.serverTimestamp(),
        'isTyping': false,
        'senderId': senderId
      });
      // Send message to receiver's chats
      await FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(senderId)
          .collection('messages')
          .add(messageModel.toMap());

      // Update last message in receiver's chat list
      await FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(senderId)
          .set({
        'lastMessage': message,
        'timestamp': FieldValue.serverTimestamp(),
        'isTyping': false,
        'senderId': senderId
      });
    } catch (error) {
      print("Error sending message: $error");
    }
  }

  // get messages
  Stream<List<MessageModel>> getMessages({
    required String senderId,
    required String receiverId,
  }) {
    return _firestore
        .collection('users')
        .doc(senderId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dataTime')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageModel.fromJson(doc.data()))
            .toList());
  }

  // update typing status
  Future<void> updateTypingStatus({
    required String senderId,
    required String receiverId,
    required bool isTyping,
  }) async {
    try {
      var chatDoc = await _firestore
          .collection('users')
          .doc(senderId)
          .collection('chats')
          .doc(receiverId)
          .get();

      if (!chatDoc.exists) {
        await _firestore
            .collection('users')
            .doc(senderId)
            .collection('chats')
            .doc(receiverId)
            .set({'isTyping': isTyping});
      } else {
        await _firestore
            .collection('users')
            .doc(senderId)
            .collection('chats')
            .doc(receiverId)
            .update({'isTyping': isTyping});
      }
    } catch (error) {
      print("Error updating typing status: $error");
    }
  }
}
