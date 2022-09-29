import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final FontStyle? fontStyle;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;

  const CustomText({
    Key? key,
    required this.text,
    this.maxLines,
    this.textDecoration,
    this.textAlign,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.fontStyle,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontStyle: fontStyle,
        overflow: overflow,
        decoration: textDecoration,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
