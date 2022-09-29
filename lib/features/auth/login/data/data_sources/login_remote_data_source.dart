import 'package:booking_app/core/error/exceptions.dart';
import 'package:booking_app/core/local/cache_helper.dart';
import 'package:booking_app/core/network/network.dart';
import 'package:booking_app/core/utilis/constants/app_strings.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../../core/network/end_points.dart';
import '../../domain/entities/user_login_entity.dart';

abstract class BaseLoginRemoteDataSource {
  Future<Unit> loginEmail({required UserLoginEntity userLoginEntity});
}

class LoginRemoteDataSource implements BaseLoginRemoteDataSource {
  @override
  Future<Unit> loginEmail({required UserLoginEntity userLoginEntity}) async {
    var formData = FormData.fromMap({
      'email': userLoginEntity.email,
      'password': userLoginEntity.password,
    });
    final response =
        await DioHelper.postData(url: loginEndPoint, data: formData);
    if (response.statusCode == 200 && response.data['status']['type'] == '1') {
      CacheHelper.saveData(
          key: AppStrings.token, value: response.data['data']['api_token']);
      debugPrint(response.data.toString());
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
