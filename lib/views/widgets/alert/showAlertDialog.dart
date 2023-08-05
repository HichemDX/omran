import 'package:bnaa/models/normalButtonWithIconModel.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/app_colors.dart';
import '../buttons/normalButtonwithIcon.dart';

showAlertDialog({required String phone}) {
  Get.defaultDialog(
    title: "",
    titlePadding: EdgeInsets.zero,
    content: Column(
      children: [
        // SvgPicture.asset(
        //   'assets/icons/orangeIcon.svg',
        //   width: 38.sp,
        //   height: 38.sp,
        // ),
        SizedBox(height: 10.h),
        Text(
          //todo translate
          'Oups !!',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Il est Impossible  d’annuler la commande une fois acceptée'.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 20.h),
        NormalButtonWithIcon(
          model: NormalButtonWithIconModel(
            textFontSize: 16.sp,
            colorText: Colors.white,
            icon: 'assets/icons/callIcon.svg',
            colorButton: AppColors.BLUE_COLOR,
            width: 130.w,
            onTap: () {
              final Uri telLaunchUri = Uri(
                scheme: 'tel',
                path: phone,
              );

              launchUrl(telLaunchUri);
            },
            height: 42.h,
            radius: 10.r,
            text: 'Appeler'.tr,
          ),
        ),
      ],
    ),
  );
}
