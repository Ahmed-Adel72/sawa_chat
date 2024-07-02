abstract class LoginStates {}

class InitialLoginState extends LoginStates {}

class ChangePasswordVisibilityState extends LoginStates {}

class UserLoginLoadingState extends LoginStates {}

class UserLoginSuccessState extends LoginStates {}

class UserLoginErrorState extends LoginStates {}
