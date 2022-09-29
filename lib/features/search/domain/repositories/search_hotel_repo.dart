import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/features/search/data/models/search_model.dart';
import 'package:booking_app/features/search/domain/entity/search_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BaseSearchHotelRepository {
  Future<Either<Failure, SearchModel>> searchHotel(
      {required UserSearchEntity userSearchEntity});
}
