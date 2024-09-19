import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa_chat/core/constants/app_constants.dart';
import 'package:sawa_chat/core/helpers/cache_helper.dart';
import 'package:sawa_chat/features/layout/data/repos/layout_repo.dart';
import 'package:sawa_chat/features/layout/logic/cubit/layout_states.dart';
import 'package:sawa_chat/features/notification/notification.dart';
import 'package:sawa_chat/features/sign_up/data/models/user_model.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  final LayoutRepo _layoutRepo;
  LayoutCubit(this._layoutRepo) : super(InitialLayoutState());
  static LayoutCubit get(context) => BlocProvider.of(context);

  var uId = CacheHelper.getData(key: 'uId');
  UserModel? myData;

  // get my data
  bool isLoadMyData = false;
  Future<void> getMyData() async {
    emit(GetMyDataLoadingState());
    isLoadMyData = true;
    try {
      await FirebaseAuthService.getAccessToken();
      myData = await _layoutRepo.getUserData(uId: uId);
      if (myData != null) {
        CacheHelper.setData(key: 'myName', value: myData!.name);
        FirebaseAuthService.getFirebaseMessagingToken();
        emit(GetMyDataSuccessState());
        isLoading = false;
      } else {
        emit(GetMyDataErrorState());
      }
    } catch (error) {
      emit(GetMyDataErrorState());
      print(error.toString());
    }
  }

  List<UserModel> myFriendsChats = [];
  List<UserModel> allUsers = [];

  bool isLoading = true;
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
                isLoading = false;
                emit(GetAllUsersSuccessState());
              }
            });
            return user;
          })
          .whereType<UserModel>()
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
}
