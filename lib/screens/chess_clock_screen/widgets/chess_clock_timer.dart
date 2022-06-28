import 'package:flutter/material.dart';

class ChessClockTimer extends StatelessWidget {
  final bool isReversed;
  final bool isTicking;
  final bool isTimeUp;
  final Function onPressed;

  final Duration availableTime;

  const ChessClockTimer({
    Key key,
    this.isReversed = false,
    this.isTicking = false,
    this.isTimeUp = false,
    this.onPressed,
    @required this.availableTime,
  }) : super(key: key);

  Color _getColor() {
    if (isTicking) {
      return Color(0xff004080);
    }

    if (isTimeUp) {
      return Color(0xff900000);
    }

    return Colors.black.withAlpha(30);
  }

  String _getAvailabeTimeText() {
    return availableTime.toString().substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        color: _getColor(),
        child: Center(
          child: RotatedBox(
            quarterTurns: isReversed ? 2 : 0,
            child: Text(
              _getAvailabeTimeText(),
              style: TextStyle(
                fontSize: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
