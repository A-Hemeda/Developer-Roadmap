class UpdateProfileModel {
  final String ar;
  final String en;

  UpdateProfileModel({
    required this.ar,
    required this.en,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileModel(
      ar: json['status']['title']['ar'],
      en: json['status']['title']['en'],
    );
  }
}
