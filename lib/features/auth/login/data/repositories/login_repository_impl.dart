import 'package:booking_app/core/error/exceptions.dart';
import 'package:booking_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/user_login_entity.dart';
import '../../domain/repositories/base_login_repository.dart';
import '../data_sources/login_remote_data_source.dart';

class LoginRepositoryImpl implements BaseLoginRepository {
  final BaseLoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoryImpl({required this.loginRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> loginEmail(
      {required UserLoginEntity userLoginEntity}) async {
    try {
      await loginRemoteDataSource.loginEmail(userLoginEntity: userLoginEntity);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
