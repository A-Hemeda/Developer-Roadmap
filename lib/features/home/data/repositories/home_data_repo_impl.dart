import 'package:booking_app/core/error/exceptions.dart';
import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/core/network/info.dart';
import 'package:booking_app/features/home/data/data_sources/home_local_data_source.dart';
import 'package:booking_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:booking_app/features/home/data/models/booking_hotel_model.dart';
import 'package:booking_app/features/home/data/models/get_booking_model.dart';
import 'package:booking_app/features/home/data/models/profile_model.dart';
import 'package:booking_app/features/home/data/models/update_profile_model.dart';
import 'package:booking_app/features/home/domain/entities/hotels_entity.dart';
import 'package:booking_app/features/home/domain/repositories/hotels_repository.dart';
import 'package:booking_app/features/home/domain/use_cases/update_profile_data_usecase.dart';
import 'package:dartz/dartz.dart';

class HomeDataRepositoryImpl extends BaseHomeDataRepository {
  final BaseHomeDataRemoteDataSource homeDataRemoteDataSource;
  final BaseHomeDataLocalDataSource homeDataLocalDataSource;
  final NetworkInfo networkInfo;

  HomeDataRepositoryImpl({
    required this.homeDataRemoteDataSource,
    required this.homeDataLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, HotelsEntity>> getHomeData({required int page}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteHome =
            await homeDataRemoteDataSource.getHomeData(page: page);
        homeDataLocalDataSource.cachedHomeData(hotelsModel: remoteHome);
        return Right(remoteHome);
      } on ServerException {
        throw Left(ServerFailure());
      }
    } else {
      try {
        final localHome = await homeDataLocalDataSource.getCachedHomeData();
        return Right(localHome);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> getProfileData() async {
    try {
      final profileData = await homeDataRemoteDataSource.getProfileData();
      return Right(profileData);
    } on ServerException {
      throw Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UpdateProfileModel>> updateProfileData(
      {required UpdateImageEntity updateImageEntity}) async {
    try {
      final updateProfileData = await homeDataRemoteDataSource
          .updateProfileData(updateImageEntity: updateImageEntity);
      return Right(updateProfileData);
    } on ServerException {
      throw Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GetBookingModel>> getBookingData(
      {required String type}) async {
    try {
      final getBooking =
          await homeDataRemoteDataSource.getBookingData(type: type);
      return Right(getBooking);
    } on ServerException {
      throw Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, BookingHotelModel>> bookingHotelData(
      {required String hotelId}) async {
    try {
      final bookingHotel =
          await homeDataRemoteDataSource.bookingHotelData(hotelId: hotelId);
      return Right(bookingHotel);
    } on ServerException {
      throw Left(ServerFailure());
    }
  }
}
