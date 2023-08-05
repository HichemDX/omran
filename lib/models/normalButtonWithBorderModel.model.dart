import 'package:bnaa/models/normalButtonModel.model.dart';
import 'package:flutter/material.dart';

class NormalButtonWithBorderModel extends NormalButtomModel {
  Color bColor;
  double wBorder; 
  NormalButtonWithBorderModel(
      {required String text,
      required Color colorText,
      required Color colorButton,
      required Function onTap,
      required this.bColor,
      required this.wBorder,
      required double width,
      required double textFontSize,
      required double height,
      required double radius})
      : super(
            text: text,
            colorText: colorText,
            colorButton: colorButton,
            onTap: onTap,
            width: width,
            textFontSize: textFontSize,
            height: height,
            radius: radius);
}
