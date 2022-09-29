class UpdateBookModel {
  final String ar;
  final String en;

  UpdateBookModel({
    required this.ar,
    required this.en,
  });

  factory UpdateBookModel.fromJson(Map<String, dynamic> json) {
    return UpdateBookModel(
      ar: json['status']['title']['ar'],
      en: json['status']['title']['en'],
    );
  }
}
