import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color colors;
  final FontWeight fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;

  const MyText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.colors = Colors.white,
      this.fontWeight = FontWeight.bold,
      this.maxLines,
      this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize,
        color: colors,
        fontWeight: fontWeight,
      ),
    );
  }
}
