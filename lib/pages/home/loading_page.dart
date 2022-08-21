import 'package:flutter/material.dart';
import '../../util/colors.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0900ff),
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(gray10),
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}
