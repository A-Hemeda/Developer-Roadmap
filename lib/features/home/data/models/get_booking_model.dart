class GetBookingModel {
  final List<GetBookingData> bookingData = [];

  GetBookingModel.fromJson(Map<String, dynamic> json) {
    json['data']['data'].forEach((data) {
      bookingData.add(GetBookingData.fromJson(data));
    });
  }
}

class GetBookingData {
  int? id;
  String? userId;
  String? type;
  Hotel? hotel;

  GetBookingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    hotel = json['hotel'] != null ? Hotel.fromJson(json['hotel']) : null;
  }
}

class Hotel {
  int? id;
  String? price;
  String? address;
  String? name;
  String? rate;
  List<HotelImages> images = [];

  Hotel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    address = json['address'];
    rate = json['rate'];
    name = json['name'];
    json['hotel_images'].forEach((image) {
      images.add(HotelImages.fromJson(image));
    });
  }
}

class HotelImages {
  final int id;
  final String hotelId;
  final String image;

  factory HotelImages.fromJson(Map<String, dynamic> json) {
    return HotelImages(
      id: json['id'],
      hotelId: json['hotel_id'],
      image: json['image'],
    );
  }

  HotelImages({
    required this.id,
    required this.hotelId,
    required this.image,
  });
}
