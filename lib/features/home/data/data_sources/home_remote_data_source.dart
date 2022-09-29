import 'dart:developer';
import 'package:booking_app/features/home/data/models/booking_hotel_model.dart';
import 'package:booking_app/features/home/data/models/get_booking_model.dart';
import 'package:dio/dio.dart';
import 'package:booking_app/core/error/exceptions.dart';
import 'package:booking_app/core/local/cache_helper.dart';
import 'package:booking_app/core/network/end_points.dart';
import 'package:booking_app/core/network/network.dart';
import 'package:booking_app/core/utilis/constants/app_strings.dart';
import 'package:booking_app/features/home/data/models/hotels_model.dart';
import 'package:booking_app/features/home/data/models/profile_model.dart';
import 'package:booking_app/features/home/data/models/update_profile_model.dart';
import 'package:booking_app/features/home/domain/use_cases/update_profile_data_usecase.dart';

abstract class BaseHomeDataRemoteDataSource {
  Future<HotelsModel> getHomeData({required int page});

  Future<ProfileModel> getProfileData();

  Future<UpdateProfileModel> updateProfileData(
      {required UpdateImageEntity updateImageEntity});

  Future<GetBookingModel> getBookingData({required String type});

  Future<BookingHotelModel> bookingHotelData({required String hotelId});
}

class HomeDataRemoteDataSource implements BaseHomeDataRemoteDataSource {
  var token = CacheHelper.getData(key: AppStrings.token);

  @override
  Future<HotelsModel> getHomeData({required int page}) async {
    final response = await DioHelper.getData(url: hotelsEndPoint, query: {
      "count": 10,
      "page": page,
    });
    if (response.statusCode == 200 && response.data['status']['type'] == '1') {
      log('home data is ${response.data}');
      return HotelsModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProfileModel> getProfileData() async {
    final response = await DioHelper.getData(
      url: profileEndPoint,
      token: token,
    );
    if (response.statusCode == 200 && response.data['status']['type'] == '1') {
      log('profile data is ${response.data}');
      return ProfileModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UpdateProfileModel> updateProfileData(
      {required UpdateImageEntity updateImageEntity}) async {
    var formData = FormData.fromMap({
      'name': updateImageEntity.name,
      'email': updateImageEntity.email,
      if (updateImageEntity.image != null)
        "image": await MultipartFile.fromFile(updateImageEntity.image!.path),
    });
    final response = await DioHelper.postData(
      url: updateProfileEndPoint,
      token: token,
      data: formData,
    );
    if (response.statusCode == 200 && response.data['status']['type'] == '1') {
      log('update profile is ${response.data}');
      return UpdateProfileModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<GetBookingModel> getBookingData({required String type}) async {
    final response = await DioHelper.getData(
      url: getBookingEndPoint,
      query: {
        "count": 10,
        "type": type,
      },
      token: token,
    );
    if (response.statusCode == 200) {
      log('getBookingData is ${response.data}');
      return GetBookingModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<BookingHotelModel> bookingHotelData({required String hotelId}) async {
    final response = await DioHelper.postData(
      url: bookingHotelEndPoint,
      token: token,
      data: {
        "hotel_id": hotelId,
      },
    );
    if (response.statusCode == 200) {
      log('Booking Hotel Data is ${response.data}');
      return BookingHotelModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
