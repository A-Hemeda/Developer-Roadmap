import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/core/usecases/usecase.dart';
import 'package:booking_app/features/home/data/models/profile_model.dart';
import 'package:booking_app/features/home/domain/repositories/hotels_repository.dart';
import 'package:dartz/dartz.dart';

class GetProfileDataUseCase extends UseCase<ProfileModel, NoParams> {
  final BaseHomeDataRepository homeDataRepository;

  GetProfileDataUseCase({required this.homeDataRepository});

  @override
  Future<Either<Failure, ProfileModel>> call(NoParams params) async {
    return await homeDataRepository.getProfileData();
  }
}
