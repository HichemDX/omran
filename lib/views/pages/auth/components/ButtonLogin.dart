import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ButtonLoginButton extends StatelessWidget {
  String text;
  Color backgroundColor;
  Color textColor;
  String icon;
  ButtonLoginButton(
      {required this.text,
      required this.icon,
      required this.backgroundColor,
      required this.textColor});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 62.h,
        width: 343.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: Offset(0, 2), // Shadow position
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 22.w,
            ),
            SvgPicture.asset(icon, height: 29.sp, width: 29.sp),
            SizedBox(
              width: 20.w,
            ),
            Text(text,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: textColor,
                ))
          ],
        ));
  }
}
