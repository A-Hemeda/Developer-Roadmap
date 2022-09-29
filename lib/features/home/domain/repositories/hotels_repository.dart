import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/features/home/data/models/booking_hotel_model.dart';
import 'package:booking_app/features/home/data/models/get_booking_model.dart';
import 'package:booking_app/features/home/data/models/profile_model.dart';
import 'package:booking_app/features/home/data/models/update_profile_model.dart';
import 'package:booking_app/features/home/domain/entities/hotels_entity.dart';
import 'package:booking_app/features/home/domain/use_cases/update_profile_data_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class BaseHomeDataRepository {
  Future<Either<Failure, HotelsEntity>> getHomeData({required int page});

  Future<Either<Failure, ProfileModel>> getProfileData();

  Future<Either<Failure, UpdateProfileModel>> updateProfileData(
      {required UpdateImageEntity updateImageEntity});

  Future<Either<Failure, GetBookingModel>> getBookingData(
      {required String type});

  Future<Either<Failure, BookingHotelModel>> bookingHotelData(
      {required String hotelId});
}
