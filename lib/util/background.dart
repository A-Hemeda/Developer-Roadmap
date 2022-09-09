import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      height: size.height,
      width: size.width,
      child: Image.asset(
        'assets/images/background/background.png',
        color: const Color(0x10003444),
        fit: BoxFit.cover,
        height: size.height,
      ),
    );
  }
}
