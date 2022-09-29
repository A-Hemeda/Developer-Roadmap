import 'dart:io';
import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/features/auth/register/domain/entities/user_info_entity.dart';
import 'package:booking_app/features/auth/register/domain/use_cases/register_email_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/utilis/constants/app_strings.dart';

part 'user_register_state.dart';

class UserRegisterCubit extends Cubit<UserRegisterState> {
  final RegisterWithEmailUseCase registerWithEmailUseCase;

  UserRegisterCubit({required this.registerWithEmailUseCase})
      : super(UserRegisterInitial());

  static UserRegisterCubit get(context) => BlocProvider.of(context);

  void registerWithEmail({required UserInfoEntity userInfoEntity}) async {
    emit(UserRegisterLoadingState());
    await registerWithEmailUseCase
        .call(UserInfoEntity(
      name: userInfoEntity.name,
      email: userInfoEntity.email,
      password: userInfoEntity.password,
      passwordConfirmation: userInfoEntity.passwordConfirmation,
    ))
        .then((value) {
      value.fold((failure) {
        print('fail');
        return emit(
            UserRegisterErrorState(error: _mapFailureToMsg(failure: failure)));
      }, (unit) {
        print('success');
        return emit(UserRegisterSuccessState());
      });
    });
  }

  String _mapFailureToMsg({required Failure failure}) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case EmptyCacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.unExpectedError;
    }
  }

  File? userImage;
  final ImagePicker picker = ImagePicker();

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      userImage = File(pickedFile.path);
      emit(SuccessGetUserImageState());
    } else {
      debugPrint('No Image Selected');
      emit(ErrorGetUserImageState());
    }
  }
}
