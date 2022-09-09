import '../../util/colors.dart';
import 'package:flutter/material.dart';

class DraggableButton extends StatelessWidget {
  final Function onDrag;

   const DraggableButton({Key key, this.onDrag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(25),
            shape: BoxShape.circle,
          ),
        ),
        Draggable(
            feedback: _buildButton(),
            child: _buildButton(),
            childWhenDragging: Container(),
            onDragEnd: (details) {
              onDrag();
            }),
      ],
    );
  }

  Widget _buildButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.arrow_drop_up,
          color: blue[200].withAlpha(150),
          size: 25,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.arrow_left,
              color: blue[200].withAlpha(150),
              size: 25,
            ),
            Icon(
              Icons.lock_open,
              color: blue[600],
              size: 25,
            ),
            Icon(
              Icons.arrow_right,
              color: blue[200].withAlpha(150),
              size: 25,
            ),
          ],
        ),
        Icon(
          Icons.arrow_drop_down,
          color: blue[200].withAlpha(150),
          size: 25,
        ),
      ],
    );
  }
}
