class BookingHotelModel {
  final String ar;
  final String en;

  BookingHotelModel({
    required this.ar,
    required this.en,
  });

  factory BookingHotelModel.fromJson(Map<String, dynamic> json) {
    return BookingHotelModel(
      ar: json['status']['title']['ar'],
      en: json['status']['title']['en'],
    );
  }
}
