import 'package:flutter/foundation.dart';

class ChessClock {
  int _startedAt = -1;
  int _millisElapsed = 0;
  final Function getNowMillis;
  int timeControlMillis;
  final int incrementsMillis;

  ChessClock({
    @required this.getNowMillis,
    @required this.timeControlMillis,
    this.incrementsMillis = 0,
  });

  void start() {
    if (_startedAt != -1) {
      return;
    }
    _startedAt = getNowMillis();
  }

  void pause() {
    if (_startedAt == -1) {
      return;
    }
    timeControlMillis += incrementsMillis;
    _millisElapsed += getNowMillis() - _startedAt;
    _startedAt = -1;
  }

  int getMillisElapsed() {
    // Timer is not running
    if (_startedAt == -1) {
      return _millisElapsed;
    }
    return getNowMillis() - _startedAt + _millisElapsed;
  }

  bool isTicking() {
    return !isTimeUp() && _startedAt != -1;
  }

  bool isTimeUp() {
    return getAvailableMillis() <= 0;
  }

  int getAvailableMillis() {
    final int availableMillis = timeControlMillis - getMillisElapsed();
    return availableMillis > 0 ? availableMillis : 0;
  }
}
