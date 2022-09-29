abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState({required this.error});
}

class SuccessGetUserImageState extends LoginState {}

class ErrorGetUserImageState extends LoginState {}

class CreateGoogleUserLoadingState extends LoginState {}

class CreateGoogleUserSuccessState extends LoginState {
  final String uId;

  CreateGoogleUserSuccessState(this.uId);
}

class CreateGoogleUserErrorState extends LoginState {}

class LoginGoogleUserLoadingState extends LoginState {}

class LoginGoogleUserSuccessState extends LoginState {
  final String uId;

  LoginGoogleUserSuccessState(this.uId);
}

class LoginGoogleUserErrorState extends LoginState {}
