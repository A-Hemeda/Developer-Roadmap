import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/features/home/data/models/booking_hotel_model.dart';
import 'package:booking_app/features/home/domain/repositories/hotels_repository.dart';
import 'package:dartz/dartz.dart';

class BookingHotelUseCase {
  final BaseHomeDataRepository homeDataRepository;

  BookingHotelUseCase({required this.homeDataRepository});

  Future<Either<Failure, BookingHotelModel>> call(
      {required String hotelId}) async {
    return await homeDataRepository.bookingHotelData(hotelId: hotelId);
  }
}
