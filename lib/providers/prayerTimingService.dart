import 'dart:convert';
import 'dart:async';
import 'package:azkark/util/print_log.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

import '../models/prayerTiming.dart';

class JsonConnection {
  static double pLat;
  static double pLong;

  Data list;

  Future getPTLocation() async {
    try {
      printLog(stateID: "423153", data: "start hossam", isSuccess: true);
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      pLat = position.latitude;
      pLong = position.longitude;
      String date = DateTime.now().toIso8601String();
      int method = 4;
      final url =
          "http://api.aladhan.com/v1/timings/$date?latitude=$pLat&longitude=$pLong&method=$method";
      http.Response res = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
        },
      );
      Map<String, dynamic> data = json.decode(res.body);
      list = Data.fromJson(data);
      printLog(stateID: "876820", data: "done", isSuccess: true);
      return list;
    } catch (error) {
      printLog(stateID: "442982", data: error.toString(), isSuccess: false);
      rethrow;
    }
  }
}
