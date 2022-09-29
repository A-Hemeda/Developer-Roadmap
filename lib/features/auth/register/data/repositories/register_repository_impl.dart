import 'package:booking_app/core/error/exceptions.dart';
import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/features/auth/register/data/data_sources/register_remote_data_source.dart';
import 'package:booking_app/features/auth/register/domain/entities/user_info_entity.dart';
import 'package:booking_app/features/auth/register/domain/repositories/base_register_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterRepositoryImpl implements BaseRegisterRepository {
  final BaseRegisterRemoteDataSource registerRemoteDataSource;

  RegisterRepositoryImpl({required this.registerRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> registerWithEmail(
      {required UserInfoEntity userInfoEntity}) async {
    try {
      await registerRemoteDataSource.registerWithEmail(
          userInfoEntity: userInfoEntity);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
