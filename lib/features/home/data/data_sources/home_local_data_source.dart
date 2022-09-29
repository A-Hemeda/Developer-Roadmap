import 'dart:convert';
import 'package:booking_app/core/error/exceptions.dart';
import 'package:booking_app/core/local/cache_helper.dart';
import 'package:booking_app/features/home/data/models/hotels_model.dart';

abstract class BaseHomeDataLocalDataSource {
  Future<HotelsModel> getCachedHomeData();

  Future<void> cachedHomeData({required HotelsModel hotelsModel});
}

class HomeDataLocalDataSourceImpl implements BaseHomeDataLocalDataSource {
  @override
  Future<HotelsModel> getCachedHomeData() {
    final jsonString = CacheHelper.getData(key: 'cachedHomeData');
    if (jsonString != null) {
      final cachedHomeData = HotelsModel.fromJson(jsonDecode(jsonString));
      return Future.value(cachedHomeData);
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<void> cachedHomeData({required HotelsModel hotelsModel}) {
    return CacheHelper.saveData(
        key: 'cachedHomeData', value: jsonEncode(hotelsModel.toJson()));
  }
}
