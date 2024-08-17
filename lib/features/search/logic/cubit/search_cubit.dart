import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa_chat/core/constants/app_constants.dart';
import 'package:sawa_chat/features/search/logic/cubit/search_state.dart';
import 'package:sawa_chat/features/sign_up/data/models/user_model.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitialSearchState());

  static SearchCubit get(context) => BlocProvider.of(context);
  List<UserModel> user = [];
  void searchUsers(BuildContext context, String value) {
    user = searchOfUser.where((user) {
      return user.name!.toLowerCase().contains(value.toLowerCase());
    }).toList();

    emit(SearchUsersState());
  }
}
