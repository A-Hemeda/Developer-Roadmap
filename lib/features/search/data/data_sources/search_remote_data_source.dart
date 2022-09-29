import 'dart:developer';
import 'package:booking_app/core/error/exceptions.dart';
import 'package:booking_app/core/network/end_points.dart';
import 'package:booking_app/core/network/network.dart';
import 'package:booking_app/features/search/data/models/search_model.dart';
import 'package:booking_app/features/search/domain/entity/search_entity.dart';

abstract class BaseSearchRemoteDataSource {
  Future<SearchModel> searchHotel({required UserSearchEntity userSearchEntity});
}

class SearchRemoteDataSourceImpl implements BaseSearchRemoteDataSource {
  @override
  Future<SearchModel> searchHotel(
      {required UserSearchEntity userSearchEntity}) async {
    final response = await DioHelper.getData(url: searchHotelsEndPoint, query: {
      "count": 10,
      "page": 1,
      if (userSearchEntity.name.isNotEmpty) "name": userSearchEntity.name,
      if (userSearchEntity.address.isNotEmpty)
        "address": userSearchEntity.address,
      if (userSearchEntity.distance.isNotEmpty)
        "distance": userSearchEntity.distance,
      if (userSearchEntity.facilities0.isNotEmpty)
        "facilities[0]": userSearchEntity.facilities0,
      if (userSearchEntity.facilities1.isNotEmpty)
        "facilities[1]": userSearchEntity.facilities1,
      if (userSearchEntity.latitude.isNotEmpty)
        "latitude": userSearchEntity.latitude,
      if (userSearchEntity.longitude.isNotEmpty)
        "longitude": userSearchEntity.longitude,
      if (userSearchEntity.maxPrice.isNotEmpty)
        "max_price": userSearchEntity.maxPrice,
      if (userSearchEntity.minPrice.isNotEmpty)
        "min_price": userSearchEntity.maxPrice,
    });
    if (response.statusCode == 200 && response.data['status']['type'] == '1') {
      log('home data is ${response.data}');
      return SearchModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
