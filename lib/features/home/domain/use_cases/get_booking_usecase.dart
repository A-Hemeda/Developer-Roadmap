import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/features/home/data/models/get_booking_model.dart';
import 'package:booking_app/features/home/domain/repositories/hotels_repository.dart';
import 'package:dartz/dartz.dart';

class GetBookingUseCase {
  final BaseHomeDataRepository homeDataRepository;

  GetBookingUseCase({required this.homeDataRepository});

  Future<Either<Failure, GetBookingModel>> call({required String type}) async {
    return await homeDataRepository.getBookingData(type: type);
  }
}
