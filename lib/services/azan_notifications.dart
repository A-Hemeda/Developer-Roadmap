import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

import '../models/prayerTiming.dart';
import '../util/print_log.dart';
import '../util/support_app.dart';
import 'services_export.dart';

List<DateTime> listAzanTime = [];
SharedPreferences myPref;
const String keyAzanDateUpdate = 'DateUpdate';
const String keyAzanSound = 'AzanSound';

setAzanSound(String azanName) async {
  try {
    myPref = await SharedPreferences.getInstance();
    await myPref.setString(keyAzanSound, azanName);

    printLog(stateID: "502109", data: "Saved Azan Sound", isSuccess: true);
  } catch (error) {
    printLog(stateID: "088183", data: error.toString(), isSuccess: false);
  }
}

Future<String> getAzanSound() async {
  try {
    myPref = await SharedPreferences.getInstance();
    String azanName = myPref.getString(keyAzanSound);

    if (azanName == null) {
      printLog(
          stateID: "355309",
          data: "Done Get Azan Sound by Default",
          isSuccess: true);
      return "a";
    } else {
      printLog(
          stateID: "539232",
          data: "Done Get Azan Sound by Saved",
          isSuccess: true);
      return azanName;
    }
  } catch (error) {
    printLog(
        stateID: "088371",
        data: "Error getAzansound${error.toString()}",
        isSuccess: false);
    return "a";
  }
}

/// Get Azan Data Source from API Next Day
Future<bool> getAzanNextDay() async {
  double pLat;
  double pLong;
  Data list;
  try {
    printLog(
        stateID: "830109", data: "Start Get Azan Next Day", isSuccess: true);
    myPref = await SharedPreferences.getInstance();

    listAzanTime.clear();

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

    listAzanTime = [
      /// Fajr index 0
      // DateTime.parse("2022-08-25 11:44"),
      DateTime.parse(myCustomDateTimeYYYYMMDD() + " " + list.data.timings.fajr),

      /// Dhuhr index 1
      DateTime.parse(
          myCustomDateTimeYYYYMMDD() + " " + list.data.timings.dhuhr),

      /// Asr index 2
      DateTime.parse(myCustomDateTimeYYYYMMDD() + " " + list.data.timings.asr),

      /// maghrib index 3
      DateTime.parse(
          myCustomDateTimeYYYYMMDD() + " " + list.data.timings.maghrib),

      /// Isha index 4
      DateTime.parse(myCustomDateTimeYYYYMMDD() + " " + list.data.timings.isha),
    ];

    myPref.setString(keyAzanDateUpdate, myCustomDateTimeYYYYMMDD());
    return true;
  } catch (error) {
    printLog(stateID: "513469", data: error.toString(), isSuccess: false);
    myPref.setString(keyAzanDateUpdate, "is Not Updated");
    return false;
  }
}

/// Step 1 of 3
startAzanNotification() async {
  // await AndroidAlarmManager.initialize();
  final NetworkInfo networkInfo =
      NetworkInfoImpl(InternetConnectionChecker.createInstance());
  myPref = await SharedPreferences.getInstance();

  if (await networkInfo.isConnected) {
    if (await getAzanNextDay() == true) {
      if (listAzanTime[0].isAfter(DateTime.now())) {
        await AndroidAlarmManager.oneShotAt(
          listAzanTime[0],
          0,
          startNotification,
          wakeup: true,
          allowWhileIdle: true,
          exact: true,
          rescheduleOnReboot: true,
        );
      }

      if (listAzanTime[1].isAfter(DateTime.now())) {
        await AndroidAlarmManager.oneShotAt(
          listAzanTime[1],
          1,
          startNotification,
          wakeup: true,
          allowWhileIdle: true,
          exact: true,
          rescheduleOnReboot: true,
        );
      }

      if (listAzanTime[2].isAfter(DateTime.now())) {
        await AndroidAlarmManager.oneShotAt(
          listAzanTime[2],
          2,
          startNotification,
          wakeup: true,
          allowWhileIdle: true,
          exact: true,
          rescheduleOnReboot: true,
        );
      }

      if (listAzanTime[3].isAfter(DateTime.now())) {
        await AndroidAlarmManager.oneShotAt(
          listAzanTime[3],
          3,
          startNotification,
          wakeup: true,
          allowWhileIdle: true,
          exact: true,
          rescheduleOnReboot: true,
        );
      }

      if (listAzanTime[4].isAfter(DateTime.now())) {
        await AndroidAlarmManager.oneShotAt(
          listAzanTime[4],
          4,
          startNotification,
          wakeup: true,
          allowWhileIdle: true,
          exact: true,
          rescheduleOnReboot: true,
        );
      }

      String fullDate = myCustomDateTimeYYYYMMDD() + " 00:10";
      await AndroidAlarmManager.oneShotAt(
          DateTime.parse(fullDate).add(const Duration(days: 1)),
          5,
          getAzanNextDay,
          wakeup: true,
          allowWhileIdle: true,
          exact: true,
          rescheduleOnReboot: true);
    } else {
      printLog(
          stateID: "521035", data: "Error in getAzanNextDay", isSuccess: false);

      /// write code here Error Server
      ///TODO AhmadCode
    }
  } else {
    printLog(
        stateID: "423196",
        data: "Error Internet not connected",
        isSuccess: false);

    /// write code here internet not connected
    ///TODO AhmadCode
  }
}

/// Step 2 of 3
void startNotification() async {
  // final int isolateId = Isolate.current.hashCode;
  await initTimeZonesAndNotification();
  printLog(stateID: "442902", data: "startNotification", isSuccess: true);
  NotificationServices().showNotification(
      id: 1,
      title: "وقت الصلاة الآن",
      body: "ما رأيت شيئاً من العبادة أشد من الصلاة في جوف الليل",
      seconds: 3,
      sound: await getAzanSound());
}

/// Step 3 of 3
initTimeZonesAndNotification() async {
  tz.initializeTimeZones();
  await NotificationServices().initNotification();
}
