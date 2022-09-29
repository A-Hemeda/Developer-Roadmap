part of 'user_register_cubit.dart';

abstract class UserRegisterState {}

class UserRegisterInitial extends UserRegisterState {}

class UserRegisterLoadingState extends UserRegisterState {}

class UserRegisterSuccessState extends UserRegisterState {}

class UserRegisterErrorState extends UserRegisterState {
  final String error;

  UserRegisterErrorState({required this.error});
}

class SuccessGetUserImageState extends UserRegisterState {}

class ErrorGetUserImageState extends UserRegisterState {}
