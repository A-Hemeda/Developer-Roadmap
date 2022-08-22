import '../../../util/colors.dart';
import 'package:flutter/material.dart';

class RowButtons extends StatelessWidget {
  final String titleFirst, titleSecond;
  final Function onTapFirst, onTapSecond;

  const RowButtons(
      {this.titleFirst, this.titleSecond, this.onTapFirst, this.onTapSecond});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildButton(
                text: titleFirst,
                isClose: false,
                onTap: onTapFirst,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildButton(
              text: titleSecond,
              isClose: true,
              onTap: onTapSecond,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButton({String text, Function onTap, bool isClose}) {
    return Material(
      color: isClose ? blue[200] : blue[600],
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        highlightColor: blue[500].withAlpha(100),
        splashColor: isClose ? blue[300] : blue[700],
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isClose ? blue[600] : blue[100],
            ),
          ),
        ),
      ),
    );
  }
}
