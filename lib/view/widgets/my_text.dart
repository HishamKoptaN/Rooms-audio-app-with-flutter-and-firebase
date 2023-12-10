import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText({
    required this.title,
    required this.textcolor,
    required this.fontSize,
    required this.fontWeight,
    required this.textDirection,
  });
  final String title;
  final Color textcolor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return Text(
      '',
      style: TextStyle(
        color: textcolor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
