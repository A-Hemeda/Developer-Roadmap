import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void printLog(
    {@required String stateID,
    @required dynamic data,
    @required bool isSuccess,
    DateTime startTime}) {
  if (foundation.kDebugMode) {
    var time = '';
    if (startTime != null) {
      final endTime = DateTime.now().difference(startTime);
      final icon = endTime.inMilliseconds > 2000
          ? '⌛️Slow-'
          : endTime.inMilliseconds > 1000
              ? '⏰Medium-'
              : '⚡️Fast-';
      time = '[$icon${endTime.inMilliseconds}ms]';
    }

    try {
      final now = DateFormat('h:mm:ss-ms').format(DateTime.now());
      // debugPrint('ℹ️[${now}ms]$time${data.toString()}');
      debugPrint(
          '🧐 ${isSuccess == true ? "🟢" : "🔴"} ${data.toString()} ℹ️[${now}ms]$time 🔑 I\'am hare [$stateID]');

      if (data.toString().contains('is not a subtype of type')) {
        throw Exception();
      }
    } catch (e, trace) {
      debugPrint('🔴 ${data.toString()} 🔑 I\'am hare [$stateID]');
      debugPrint("$trace 🔑 Iam hare [$stateID]");
    }
  }
}
