import 'package:booking_app/core/error/exceptions.dart';
import 'package:booking_app/core/network/network.dart';
import 'package:booking_app/features/auth/register/domain/entities/user_info_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../../core/network/end_points.dart';

abstract class BaseRegisterRemoteDataSource {
  Future<Unit> registerWithEmail({required UserInfoEntity userInfoEntity});
}

class RegisterRemoteDataSource implements BaseRegisterRemoteDataSource {
  @override
  Future<Unit> registerWithEmail(
      {required UserInfoEntity userInfoEntity}) async {
    var formData = FormData.fromMap({
      'name': userInfoEntity.name,
      'email': userInfoEntity.email,
      'password': userInfoEntity.password,
      'password_confirmation': userInfoEntity.passwordConfirmation,
      // "image": await MultipartFile.fromFile(userInfoEntity.image.path),
    });
    final response =
        await DioHelper.postData(url: registerEndPoint, data: formData);

    if (response.statusCode == 200 && response.data['status']['type'] == '1') {
      debugPrint(response.data.toString());
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
