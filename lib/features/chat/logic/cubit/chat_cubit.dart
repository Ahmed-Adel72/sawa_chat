import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa_chat/core/helpers/cache_helper.dart';
import 'package:sawa_chat/features/chat/data/models/message_model.dart';
import 'package:sawa_chat/features/chat/data/repos/chat_repo.dart';
import 'package:sawa_chat/features/chat/logic/cubit/chat_states.dart';
import 'package:sawa_chat/features/notification/notification.dart';
import 'package:sawa_chat/features/sign_up/data/models/user_model.dart';

class ChatCubit extends Cubit<ChatStates> {
  final ChatRepo _chatRepo;
  ChatCubit(this._chatRepo) : super(InitialChatStates());

  static ChatCubit get(context) => BlocProvider.of(context);
  TextEditingController messageController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  UserModel? userData;
  StreamSubscription<List<MessageModel>>? _messageSubscription;

  var uId = CacheHelper.getData(key: 'uId');
  var myName = CacheHelper.getData(key: 'myName');

  // get user data
  bool isLoadUserData = false;
  Future<void> getUserData({required String uid}) async {
    emit(GetUserDataLoadingState());
    isLoadUserData = true;
    try {
      userData = await _chatRepo.getUserData(uid);
      if (userData != null) {
        emit(GetUserDataSuccessState());
        getMessage(receiverId: uid);
      }
      isLoadUserData = false;
    } catch (error) {
      emit(GetUserDataErrorState());
      isLoadUserData = false;
    }
  }

  // send message
  void sendMessage(
      {required String receiverId, required String message}) async {
    if (uId == null || receiverId.isEmpty) return;

    MessageModel messageModel = MessageModel(
      senderId: uId!,
      receiverId: receiverId,
      dataTime: FieldValue.serverTimestamp(),
      text: message,
    );

    try {
      // Send message to my chats
      await _chatRepo.sendMessage(
          senderId: uId,
          receiverId: receiverId,
          messageModel: messageModel,
          message: message);
      FirebaseAuthService.sendNotification(
          name: "$myName",
          lastMessage: message,
          userPushToken: "${userData!.pushToken}");
      emit(SendMessageSuccessState());
      _scrollToBottom();
    } catch (error) {
      print(error.toString());
      emit(SendMessageErrorState());
    }
  }

  // get messages
  List<MessageModel> messages = [];
  void getMessage({required String receiverId}) {
    _messageSubscription?.cancel();
    if (uId == null || receiverId.isEmpty) {
      emit(GetMessagesErrorState());
      return;
    }
    emit(GetMessagesLoadingState());
    _messageSubscription = _chatRepo
        .getMessages(senderId: uId!, receiverId: receiverId)
        .listen((messageList) {
      messages = messageList;
      emit(GetMessagesSuccessState());
      _scrollToBottom();
    });
  }

  bool checkingTyping = false;
  void checkTyping(bool text) {
    checkingTyping = text;
    emit(CheckUserTypingStatusState());
  }

  // update typing status
  void updateTypingStatus(
      {required String receiverId, required bool isTyping}) async {
    if (uId == null || receiverId.isEmpty) return;
    try {
      await _chatRepo.updateTypingStatus(
        senderId: uId!,
        receiverId: receiverId,
        isTyping: isTyping,
      );
      emit(UpdateTypingStatusState());
    } catch (error) {
      print(error.toString());
    }
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
