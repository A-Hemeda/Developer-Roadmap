import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import '../entities/user_login_entity.dart';
import '../repositories/base_login_repository.dart';

class LoginUseCase implements UseCase<Unit, UserLoginEntity> {
  final BaseLoginRepository loginRepository;

  LoginUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, Unit>> call(UserLoginEntity userLoginEntity) async {
    return await loginRepository.loginEmail(userLoginEntity: userLoginEntity);
  }
}
