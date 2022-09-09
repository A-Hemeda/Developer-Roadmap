class SupportApp {}

/// For Example 2022-08-21
String myCustomDateTimeYYYYMMDD() {
  String year = DateTime.now().year.toString();
  String month;
  if (DateTime.now().month < 10) {
    month = "0${DateTime.now().month}";
  } else {
    month = DateTime.now().month.toString();
  }
  String day;
  if (DateTime.now().day < 10) {
    day = "0${DateTime.now().day}";
  } else {
    day = DateTime.now().day.toString();
  }
  return "$year-$month-$day";
}

/// For Example 01:09
String myCustomDateTimeHHMM() {
  String hour;
  if (DateTime.now().hour < 10) {
    hour = "0${DateTime.now().hour.toString()}";
  } else {
    hour = DateTime.now().hour.toString();
  }
  String minute;
  if (DateTime.now().minute < 10) {
    minute = "0${DateTime.now().minute.toString()}";
  } else {
    minute = DateTime.now().minute.toString();
  }
  return "$hour:$minute";
}
