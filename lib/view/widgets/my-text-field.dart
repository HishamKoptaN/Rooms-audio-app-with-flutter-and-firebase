import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    key,
    required this.font,
    required this.color,
    required this.fontWeight,
    required this.controller,
    required this.inputType,
    required this.hintText,
    required this.borderColor,
    required this.fontSize,
    required this.widthBorder,
    required this.textcolor,
    required this.containerWidth,
    required this.containerHeight,
    required this.prefixIcon,
  });
  final double? font;
  final Color? color;
  final FontWeight? fontWeight;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final String? hintText;
  final Color? borderColor;
  final double? fontSize;
  final double? widthBorder;
  final Color? textcolor;
  final double? containerWidth;
  final double? containerHeight;
  final Widget? prefixIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      child: Center(
        child: TextField(
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: font,
            color: color,
            fontWeight: fontWeight,
          ),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            hintText: hintText,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black, // لون الحدود
                width: 2.0, // سمك الحدود
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue, // لون الحدود عند التركيز
                width: 2.0, // سمك الحدود عند التركيز
              ),
            ),
          ),
        ),
      ),
    );
  }
}
