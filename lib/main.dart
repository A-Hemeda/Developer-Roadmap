import 'package:flutter/material.dart';
import 'screens/chess_clock_screen/chess_clock_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Chess Timer",
      home: ChessClockScreen(),
    );
  }
}
