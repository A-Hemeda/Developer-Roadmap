import 'package:booking_app/features/home/domain/entities/hotels_entity.dart';

class HotelsModel extends HotelsEntity {
  const HotelsModel({
    required super.homeEntity,
  });

  factory HotelsModel.fromJson(Map<String, dynamic> json) {
    return HotelsModel(
      homeEntity: HotelHomeModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": homeEntity,
    };
  }
}

class HotelHomeModel extends HotelHomeEntity {
  const HotelHomeModel({
    required super.data,
    required super.lastPage,
  });

  factory HotelHomeModel.fromJson(Map<String, dynamic> json) {
    return HotelHomeModel(
      data: List<DataHotelModel>.from((json['data'] as List)
          .map((hotel) => DataHotelModel.fromJson(hotel))),
      lastPage: json['last_page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": data,
      "last_page": lastPage,
    };
  }
}

class DataHotelModel extends DataHotelEntity {
  const DataHotelModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.latitude,
    required super.longitude,
    required super.address,
    required super.rate,
    required super.images,
  });

  factory DataHotelModel.fromJson(Map<String, dynamic> json) {
    return DataHotelModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      address: json['address'],
      rate: json['rate'],
      images: List<HotelImageModel>.from(
          json['hotel_images'].map((image) => HotelImageModel.fromJson(image))),
      latitude: json['latitude'],
      longitude: json['longitude'],
      // images: List<HotelImageModel>.from(json['hotel_images'].map((image) => HotelImageModel.fromJson(image))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "address": address,
      "rate": rate,
      "images": images,
    };
  }
}

class HotelImageModel extends HotelImages {
  const HotelImageModel({
    required super.id,
    required super.hotelID,
    required super.image,
  });

  factory HotelImageModel.fromJson(Map<String, dynamic> json) {
    return HotelImageModel(
      id: json['id'],
      hotelID: json['hotel_id'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "hotel_id": hotelID,
      "image": image,
    };
  }
}

/// cubit@mail.com
