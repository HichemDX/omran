import 'package:flutter/material.dart';

class NormalButtomModel {
  String text;
  Color colorText;
  Color colorButton;
  double radius;
  double width;
  double height;
  double textFontSize; 
  Function onTap;
  NormalButtomModel(
      {required this.text,
      required this.colorText,
      required this.colorButton,
      required this.onTap,
      required this.width,
      required this.textFontSize, 
      required this.height,
      required this.radius});
}
