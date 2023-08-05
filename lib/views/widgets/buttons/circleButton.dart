import 'package:bnaa/models/circleButtonModel.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CircleButton extends StatelessWidget {
  CircleButtomModel model;
  CircleButton({required this.model});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          model.onTap();
        },
        child: Container(
          height: model.height,
          width: model.width,
          padding: EdgeInsets.all(17.sp),
          child: SvgPicture.asset(model.icon, height: 24.sp, width: 24.sp),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: model.color,
          ),
        ));
  }
}
