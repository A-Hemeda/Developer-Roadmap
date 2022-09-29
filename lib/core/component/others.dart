import 'package:flutter/material.dart';

void navigateTo({
  required BuildContext context,
  required Widget widget,
}) =>
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => widget),
    );

void navigateAndFinish({
  required BuildContext context,
  required Widget widget,
}) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void printFullText(String? text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text!).forEach((match) => debugPrint(match.group(0)));
}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
}
