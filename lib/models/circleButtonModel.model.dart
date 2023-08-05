import 'package:flutter/material.dart';

class CircleButtomModel {
  double height;
  double width;
  String icon;
  Color color;

  Function onTap;
  CircleButtomModel(
      {required this.height,
      required this.color,
      required this.onTap,
      required this.icon,
      required this.width});
}
