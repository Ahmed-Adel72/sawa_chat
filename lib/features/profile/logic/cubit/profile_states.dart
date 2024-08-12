abstract class ProfileStates {}

class InitialProfileState extends ProfileStates {}

class GetUserDataLoadingState extends ProfileStates {}

class GetUserDataSuccessState extends ProfileStates {}

class GetUserDataErrorState extends ProfileStates {}

class UpdateUserDataLoadingState extends ProfileStates {}

class UpdateUserDataSuccessState extends ProfileStates {}

class UpdateUserDataErrorState extends ProfileStates {
  final String error;

  UpdateUserDataErrorState({required this.error});
}

class ProfileImagePickedSuccessState extends ProfileStates {}

class ProfileImagePickedErrorState extends ProfileStates {}

class ProfileImageUploadLoadingState extends ProfileStates {}

class ProfileImageUploadSuccessState extends ProfileStates {}

class ProfileImageUploadErrorState extends ProfileStates {
  final String error;

  ProfileImageUploadErrorState({required this.error});
}
