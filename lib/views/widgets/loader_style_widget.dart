import 'package:bnaa/constants/app_colors.dart';
import 'package:flutter/material.dart';
class LoaderStyleWidget extends StatelessWidget {
  double strokeWidth;

  LoaderStyleWidget({this.strokeWidth = 3.0});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: strokeWidth,
      color: AppColors.BLUE_COLOR2,
    );
  }
}
