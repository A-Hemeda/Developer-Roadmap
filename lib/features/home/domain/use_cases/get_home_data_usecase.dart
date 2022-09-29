import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/core/usecases/usecase.dart';
import 'package:booking_app/features/home/domain/entities/hotels_entity.dart';
import 'package:booking_app/features/home/domain/repositories/hotels_repository.dart';
import 'package:dartz/dartz.dart';

class GetHomeDataUseCase {
  final BaseHomeDataRepository homeDataRepository;

  GetHomeDataUseCase({required this.homeDataRepository});

  Future<Either<Failure, HotelsEntity>> call(
      {required NoParams params, required int page}) async {
    return await homeDataRepository.getHomeData(page: page);
  }
}
