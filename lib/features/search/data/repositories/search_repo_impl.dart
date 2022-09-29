import 'package:booking_app/core/error/exceptions.dart';
import 'package:booking_app/core/error/failures.dart';
import 'package:booking_app/core/network/info.dart';
import 'package:booking_app/features/search/data/data_sources/search_remote_data_source.dart';
import 'package:booking_app/features/search/data/models/search_model.dart';
import 'package:booking_app/features/search/domain/entity/search_entity.dart';
import 'package:booking_app/features/search/domain/repositories/search_hotel_repo.dart';
import 'package:dartz/dartz.dart';

class SearchHotelRepositoryImpl implements BaseSearchHotelRepository {
  final BaseSearchRemoteDataSource searchRemoteDataSource;
  final NetworkInfo networkInfo;

  SearchHotelRepositoryImpl(
      {required this.searchRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, SearchModel>> searchHotel(
      {required UserSearchEntity userSearchEntity}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteHome = await searchRemoteDataSource.searchHotel(
            userSearchEntity: userSearchEntity);
        return Right(remoteHome);
      } on ServerException {
        throw Left(ServerFailure());
      }
    } else {
      throw ServerFailure();
    }
  }
}
