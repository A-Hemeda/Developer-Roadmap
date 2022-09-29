import 'package:equatable/equatable.dart';

class HotelsEntity extends Equatable {
  final HotelHomeEntity homeEntity;

  const HotelsEntity({
    required this.homeEntity,
  });

  @override
  List<Object> get props => [
        homeEntity,
      ];
}

class HotelHomeEntity extends Equatable {
  final List<DataHotelEntity> data;
  final int lastPage;

  const HotelHomeEntity({
    required this.data,
    required this.lastPage,
  });

  @override
  List<Object> get props => [
        data,
        lastPage,
      ];
}

class DataHotelEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String price;
  final String address;
  final String rate;
  final String latitude;
  final String longitude;
  final List<HotelImages> images;

  const DataHotelEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.address,
    required this.rate,
    required this.images,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [
        id,
        name,
        description,
        price,
        address,
        rate,
        images,
      ];
}

class HotelImages extends Equatable {
  final int id;
  final String hotelID;
  final String image;

  const HotelImages({
    required this.id,
    required this.hotelID,
    required this.image,
  });

  @override
  List<Object> get props => [
        id,
        hotelID,
        image,
      ];
}
