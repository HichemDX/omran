import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';

AppBarWidget({required String title, required String icon}) {
  return AppBar(
    elevation: 0,
    backgroundColor: AppColors.BLUE_COLOR,
    leadingWidth: 25.sp,
    centerTitle: true,
    leading: Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios,color: Colors.white),
      ),
    ),
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
}
