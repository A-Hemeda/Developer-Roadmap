import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/features/search/data/models/search_model.dart';
import 'package:booking_app/features/search/domain/entity/search_entity.dart';
import 'package:booking_app/features/search/domain/repositories/search_hotel_repo.dart';
import 'package:dartz/dartz.dart';

class SearchHotelUseCase {
  final BaseSearchHotelRepository searchHotelRepository;

  SearchHotelUseCase({required this.searchHotelRepository});

  Future<Either<Failure, SearchModel>> call(
      {required UserSearchEntity userSearchEntity}) async {
    return await searchHotelRepository.searchHotel(
        userSearchEntity: userSearchEntity);
  }
}
