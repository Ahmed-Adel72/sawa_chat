import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa_chat/core/helpers/cache_helper.dart';
import 'package:sawa_chat/features/layout/logic/cubit/layout_states.dart';
import 'package:sawa_chat/features/sign_up/data/models/user_model.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(InitialLayoutState());
  static LayoutCubit get(context) => BlocProvider.of(context);

  var uId = CacheHelper.getData(key: 'uId');

  UserModel? myData;
  bool isLoadMyData = false;
  Future<void> getMyData() async {
    emit(GetMyDataLoadingState());
    bool isLaodMyData = true;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      print(value.data());
      myData = UserModel.fromJson(value.data()!);
      emit(GetMyDataSuccessState());
      isLaodMyData = false;
    }).catchError((error) {
      emit(GetMyDataErrorState());
      isLaodMyData = false;
    });
  }

  List<UserModel> allUser = [];

  Future<void> getAllUsers() async {
    emit(GetAllUsersLoadingState());

    try {
      var userDocs = await FirebaseFirestore.instance.collection('users').get();

      allUser = userDocs.docs
          .map((doc) {
            var user = UserModel.fromJson(doc.data());

            // Only include users in myUsersChat
            if (!myUsersChat.contains(user.uId)) {
              return null;
            }

            // Listen to real-time updates for each user's last message
            FirebaseFirestore.instance
                .collection('users')
                .doc(uId)
                .collection('chats')
                .doc(user.uId)
                .snapshots()
                .listen((chatDoc) {
              if (chatDoc.exists) {
                user.isTyping = chatDoc.data()?['isTyping'] ?? false;
                user.senderId = chatDoc.data()?['senderId'] ?? '';
                user.lastMessage =
                    chatDoc.data()?['lastMessage'] ?? 'No messages yet';
                user.timestamp =
                    chatDoc.data()?['timestamp']?.toDate() ?? DateTime.now();
                emit(GetAllUsersSuccessState()); // Emit state to refresh UI
              }
            });

            return user;
          })
          .whereType<UserModel>() // Filter out any nulls
          .toList();

      emit(GetAllUsersSuccessState());
    } catch (error) {
      emit(GetAllUsersErrorState());
    }

    print(allUser);
  }

  List<String> myUsersChat = [];
  Future<void> getMyUsersChats() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .get()
        .then((value) {
      myUsersChat = value.docs.map((doc) => doc.id).toList();
      print('Chat UIDs: $myUsersChat');
      getAllUsers();
      emit(GetMyUsersChatSuccessState());
    }).catchError((error) {
      emit(GetMyUsersChatErrorState());
      print(error.toString());
    });
  }

  String lastMessage = '';
  String lastMessageTime = '';

  void listenToLastMessage({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .snapshots()
        .listen((docSnapshot) {
      if (docSnapshot.exists) {
        lastMessage = docSnapshot.data()?['lastMessage'] ?? 'No messages yet';
        lastMessageTime = (docSnapshot.data()?['timestamp'] as Timestamp?)
                ?.toDate()
                .toString() ??
            '';
        emit(UpdateLastMessageState()); // Emit a state to update the UI
      } else {
        lastMessage = 'No messages yet';
        lastMessageTime = '';
        emit(UpdateLastMessageState()); // Emit a state to update the UI
      }
    });
  }
}
