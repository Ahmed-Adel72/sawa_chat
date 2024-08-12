import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sawa_chat/features/sign_up/data/models/user_model.dart';
import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(InitialProfileState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  var emailController = TextEditingController();
  var bioController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  UserModel? userData;

  Future<void> getUserData({required String uid}) async {
    emit(GetUserDataLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      userData = UserModel.fromJson(value.data()!);
      emailController.text = userData!.name.toString();
      bioController.text = userData!.bio.toString();
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState());
    });
  }

  Future<void> updateUserData({required String uid}) async {
    emit(UpdateUserDataLoadingState());
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'name': emailController.text,
        'bio': bioController.text,
      });

      // Fetch the updated user data from Firestore
      var updatedUserDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userData = UserModel.fromJson(updatedUserDoc.data()!);
      emailController.text = userData!.name.toString();
      bioController.text = userData!.bio.toString();

      emit(UpdateUserDataSuccessState());
    } catch (error) {
      print(error.toString());
      emit(UpdateUserDataErrorState(error: error.toString()));
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(profileImage);
      emit(ProfileImagePickedSuccessState());
    } else {
      emit(ProfileImagePickedErrorState());
      print('No image selected');
    }
  }

  Future<void> updateProfileImage({required String uid}) async {
    if (profileImage != null) {
      emit(ProfileImageUploadLoadingState());
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}');

      try {
        // Upload the file to Firebase Storage
        await storageRef.putFile(profileImage!);
        final downloadUrl = await storageRef.getDownloadURL();

        // Update Firestore with the new image URL
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'image': downloadUrl,
          'name': emailController.text,
          'bio': bioController.text,
        });
        print(downloadUrl);

        emit(ProfileImageUploadSuccessState());
      } catch (error) {
        emit(ProfileImageUploadErrorState(error: error.toString()));
        print(error.toString());
      }
    }
  }
}
