import 'package:bnaa/models/normalButtonModel.model.dart';
import 'package:flutter/material.dart';
class NormalButtonWithIconModel extends NormalButtomModel {
  String icon;
  NormalButtonWithIconModel(
      {required String text,
      required Color colorText,
      required Color colorButton,
      required Function onTap,
      required this.icon,
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
