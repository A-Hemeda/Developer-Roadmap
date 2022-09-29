import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? minWidth;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget child;
  final double radius;

  const CustomButton({
    Key? key,
    required this.onPressed,
    this.minWidth,
    this.height,
    this.radius = 0,
    this.textColor,
    this.backgroundColor,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      height: height,
      color: backgroundColor,
      minWidth: minWidth,
      onPressed: onPressed,
      textColor: textColor,
      child: child,
    );
  }
}
