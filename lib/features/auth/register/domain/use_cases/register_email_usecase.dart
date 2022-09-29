import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/core/usecases/usecase.dart';
import 'package:booking_app/features/auth/register/domain/entities/user_info_entity.dart';
import 'package:booking_app/features/auth/register/domain/repositories/base_register_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterWithEmailUseCase implements UseCase<Unit, UserInfoEntity> {
  final BaseRegisterRepository registerRepository;

  RegisterWithEmailUseCase({required this.registerRepository});

  @override
  Future<Either<Failure, Unit>> call(UserInfoEntity userInfoEntity) async {
    return await registerRepository.registerWithEmail(
        userInfoEntity: userInfoEntity);
  }
}
