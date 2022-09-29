part of 'search_model.dart';

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) => SearchModel(
      data: SearchDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchModelToJson(SearchModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

SearchDataModel _$SearchDataModelFromJson(Map<String, dynamic> json) =>
    SearchDataModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => DataHotelModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastPage: json['last_page'] as int,
    );

Map<String, dynamic> _$SearchDataModelToJson(SearchDataModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'last_page': instance.lastPage,
    };

DataHotelModel _$DataHotelModelFromJson(Map<String, dynamic> json) =>
    DataHotelModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      address: json['address'] as String,
      rate: json['rate'] as String,
      images: (json['hotel_images'] as List<dynamic>)
          .map((e) => SearchHotelImages.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataHotelModelToJson(DataHotelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'address': instance.address,
      'rate': instance.rate,
      'hotel_images': instance.images,
    };

SearchHotelImages _$SearchHotelImagesFromJson(Map<String, dynamic> json) =>
    SearchHotelImages(
      id: json['id'] as int,
      hotelID: json['hotel_id'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$SearchHotelImagesToJson(SearchHotelImages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hotel_id': instance.hotelID,
      'image': instance.image,
    };
