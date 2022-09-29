import 'package:booking_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/user_login_entity.dart';

abstract class BaseLoginRepository {
  Future<Either<Failure, Unit>> loginEmail(
      {required UserLoginEntity userLoginEntity});
}
