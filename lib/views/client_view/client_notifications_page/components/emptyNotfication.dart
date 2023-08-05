import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EmptyNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/clockIcon.svg',
          height: 92.sp,
          width: 92.sp,
        ),
        SizedBox(
          height: 24.h,
        ),
        Text('no notifications to show'.tr,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: Colors.black,
            )),
        SizedBox(
          height: 8.h,
        ),
      ],
    );
  }
}
