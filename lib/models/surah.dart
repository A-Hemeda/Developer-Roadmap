import 'dart:convert';

class Surah {
  int id;
  String revelationPlace;
  int revelationOrder;
  String name;
  String arabicName;
  int versesCount;

  Surah({
    this.arabicName,
    this.id,
    this.name,
    this.revelationOrder,
    this.revelationPlace,
    this.versesCount,
  });

  factory Surah.fromMap(Map<String, dynamic> json) => Surah(
        arabicName: json["name_arabic"],
        id: json["id"],
        name: json["name_simple"],
        revelationOrder: json["revelation_order"],
        revelationPlace: json["revelation_place"],
        versesCount: json["verses_count"],
      );
}
