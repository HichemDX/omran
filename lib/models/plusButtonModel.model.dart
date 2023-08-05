import 'package:flutter/material.dart';

class PlusButtonModel {
  String text;
  Color colorText;
  Color colorBackground;
  double radius;
  double width;
  double height;
  double textFontSize;
  Function onTap;
  String icon; 
  PlusButtonModel({
    required this.text,
    required this.icon, 
    required this.colorText,
    required this.colorBackground,
    required this.radius,
    required this.width,
    required this.height,
    required this.onTap,
    required this.textFontSize,
  });
}
