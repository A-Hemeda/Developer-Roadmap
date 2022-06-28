import 'dart:async';
import 'package:chessclock/utils/chess_clock.dart';
import 'package:flutter/material.dart';
import 'widgets/chess_clock_timer.dart';

class ChessClockScreen extends StatefulWidget {
  @override
  _ChessClockScreenState createState() => _ChessClockScreenState();
}

class _ChessClockScreenState extends State<ChessClockScreen> {
  ChessClock _topClock = ChessClock(
    getNowMillis: () => DateTime.now().millisecondsSinceEpoch,
    timeControlMillis: 20 * 60 * 1000,
    incrementsMillis: 1000,
  );

  ChessClock _bottomClock = ChessClock(
    getNowMillis: () => DateTime.now().millisecondsSinceEpoch,
    timeControlMillis: 20 * 60 * 1000,
    incrementsMillis: 1000,
  );

  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _onTopPressed() {
    _topClock.pause();
    _bottomClock.start();
  }

  void _onBottomPressed() {
    _bottomClock.pause();
    _topClock.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ChessClockTimer(
              onPressed: _onTopPressed,
              isReversed: true,
              isTicking: _topClock.isTicking(),
              isTimeUp: _topClock.isTimeUp(),
              availableTime: Duration(
                milliseconds: _topClock.getAvailableMillis(),
              ),
            ),
          ),
          Expanded(
            child: ChessClockTimer(
              onPressed: _onBottomPressed,
              isTicking: _bottomClock.isTicking(),
              isTimeUp: _bottomClock.isTimeUp(),
              availableTime: Duration(
                milliseconds: _bottomClock.getAvailableMillis(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
