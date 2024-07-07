import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa_chat/core/constants/app_constants.dart';
import 'package:sawa_chat/features/layout/logic/cubit/layout_states.dart';
import 'package:sawa_chat/features/sign_up/data/models/user_model.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(InitialLayoutState());
  static LayoutCubit get(context) => BlocProvider.of(context);

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
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach(
        (element) {
          allUser.add(UserModel.fromJson(element.data()));
        },
      );
      print(allUser);
      emit(GetAllUsersSuccessState());
    }).catchError((error) {
      emit(GetAllUsersErrorState());
    });
  }

  UserModel? userData;
  bool isLoadUserData = false;
  Future<void> getUserData({required String uid}) async {
    emit(GetUserDataLoadingState());
    bool isLoadUserData = true;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      print(value.data());
      userData = UserModel.fromJson(value.data()!);
      emit(GetUserDataSuccessState());
      isLoadUserData = false;
    }).catchError((error) {
      emit(GetUserDataErrorState());
      isLoadUserData = false;
    });
  }
}
