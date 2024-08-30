import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa_chat/core/constants/app_constants.dart';
import 'package:sawa_chat/core/helpers/cache_helper.dart';
import 'package:sawa_chat/features/layout/logic/cubit/layout_states.dart';
import 'package:sawa_chat/features/notification/notification.dart';
import 'package:sawa_chat/features/sign_up/data/models/user_model.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(InitialLayoutState());
  static LayoutCubit get(context) => BlocProvider.of(context);

  var uId = CacheHelper.getData(key: 'uId');
  UserModel? myData;

  Future<void> getMyData() async {
    emit(GetMyDataLoadingState());
    await FirebaseAuthService.getAccessToken();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      print(value.data());
      myData = UserModel.fromJson(value.data()!);
      CacheHelper.setData(key: 'myName', value: value.data()!['name']);

      FirebaseAuthService.getFirebaseMessagingToken();
      emit(GetMyDataSuccessState());
    }).catchError((error) {
      emit(GetMyDataErrorState());
      print(error.toString());
    });
  }

  List<UserModel> myFriendsChats = [];
  List<UserModel> allUsers = [];

  Future<void> getAllUsers() async {
    emit(GetAllUsersLoadingState());

    try {
      var userDocs = await FirebaseFirestore.instance.collection('users').get();
      allUsers = userDocs.docs.map((doc) {
        return UserModel.fromJson(doc.data());
      }).toList();
      myFriendsChats = userDocs.docs
          .map((doc) {
            var user = UserModel.fromJson(doc.data());

            // Only include users in myUsersChat
            if (!myUsersChat.contains(user.uId)) {
              return null;
            }

            // Listen to real-time updates for each user's last message
            FirebaseFirestore.instance
                .collection('users')
                .doc(user.uId)
                .collection('chats')
                .doc(uId)
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
      searchOfUser = allUsers;
      emit(GetAllUsersSuccessState());
    } catch (error) {
      emit(GetAllUsersErrorState());
    }
  }

  StreamSubscription<QuerySnapshot>? _chatSubscription;

  List<String> myUsersChat = [];
  Future<void> getMyUsersChats() async {
    _chatSubscription?.cancel();

    _chatSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .snapshots()
        .listen((snapshot) {
      myUsersChat = snapshot.docs.map((doc) => doc.id).toList();
      getAllUsers(); // Fetch the updated user list
      emit(GetMyUsersChatSuccessState());
    });
  }

  @override
  Future<void> close() {
    _chatSubscription?.cancel();
    return super.close();
  }

  ///////////////////////////
}
