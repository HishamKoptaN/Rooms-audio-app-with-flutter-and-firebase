import 'package:flutter/material.dart';

class AppLargeButtons extends StatelessWidget {
  const AppLargeButtons({
    required this.height,
    required this.width,
    required this.backgroundColor,
    required this.text,
    required this.textColor,
    required this.fontSize,
  });
  final double height;
  final double width;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            // border: Border.all(
            //   width: 2,
            //   color: Colors.blue,
            // ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
