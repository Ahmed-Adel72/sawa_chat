import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa_chat/core/helpers/cache_helper.dart';
import 'package:sawa_chat/features/chat/data/models/message_model.dart';
import 'package:sawa_chat/features/chat/logic/cubit/chat_states.dart';
import 'package:sawa_chat/features/sign_up/data/models/user_model.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(InitialChatStates());

  static ChatCubit get(context) => BlocProvider.of(context);

  TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  UserModel? userData;
  StreamSubscription<QuerySnapshot>? _messageSubscription;

  bool isLoadUserData = false;
  Future<void> getUserData({required String uid}) async {
    emit(GetUserDataLoadingState());
    bool isLoadUserData = true;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      userData = UserModel.fromJson(value.data()!);
      emit(GetUserDataSuccessState());
      getMessage(receiverId: uid);
      isLoadUserData = false;
    }).catchError((error) {
      emit(GetUserDataErrorState());
      isLoadUserData = false;
    });
  }

  var uId = CacheHelper.getData(key: 'uId');
  void sendMessage({required String receiverId}) {
    if (uId == null || receiverId.isEmpty) return;

    MessageModel messageModel = MessageModel(
      senderId: uId,
      receiverId: receiverId,
      dataTime: FieldValue.serverTimestamp(),
      text: messageController.text,
    );
    // set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      messageController.clear();
      emit(SendMessageSuccessState());
      _scrollToBottom();
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageErrorState());
    });
    // set receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
      _scrollToBottom();
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  void getMessage({required String receiverId}) {
    _messageSubscription?.cancel();

    if (uId == null || receiverId.isEmpty) {
      emit(GetMessagesErrorState());
      return;
    }
    emit(GetMessagesLoadingState());
    _messageSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dataTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessagesSuccessState());
      _scrollToBottom();
    });
  }

  bool isTypingRealy = false;
  void updateTypingStatus(
      {required String receiverId, required bool isTyping}) {
    if (uId == null || receiverId.isEmpty) return;

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .set({'isTyping': isTyping, 'senderId': uId}, SetOptions(merge: true));
    emit(UpdateTypingStatusState());
    isTypingRealy = isTyping;
    print(isTyping);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 50),
        curve: Curves.easeOut,
      );
    });
  }

  void closeMessageSubscription() {
    _messageSubscription?.cancel();
    _messageSubscription = null;
  }

  @override
  Future<void> close() {
    closeMessageSubscription();
    return super.close();
  }
}
