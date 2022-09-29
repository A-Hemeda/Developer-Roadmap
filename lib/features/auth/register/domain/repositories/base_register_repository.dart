import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/features/auth/register/domain/entities/user_info_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BaseRegisterRepository {
  Future<Either<Failure, Unit>> registerWithEmail(
      {required UserInfoEntity userInfoEntity});
}
