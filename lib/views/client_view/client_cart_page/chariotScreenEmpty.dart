import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/client_controllers/client_navigation_controller.dart';
import 'package:bnaa/views/widgets/buttons/NormalButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../models/normalButtonModel.model.dart';

class CharioScreenEmpty extends StatelessWidget {
  final ClientNavigationController navigationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 41.h),
          // SvgPicture.asset(
          //   'assets/icons/logo.png',
          //   width: 67.sp,
          //   height: 67.sp,
          // ),
          SizedBox(
            height: 80.h,
          ),
          SvgPicture.asset(
            'assets/icons/exlamationIcon.svg',
            width: 67.sp,
            height: 67.sp,
          ),
          SizedBox(height: 25.h),
          Text('your cart is empty'.tr,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: Colors.black)),
          SizedBox(height: 13.h),
          Text('consult stores to add products'.tr,
              style: TextStyle(
                  color: AppColors.GREY_TEXT_COLOR,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300)),
          SizedBox(height: 25.h),
          NormalButton(
            model: NormalButtomModel(
                textFontSize: 12.sp,
                colorText: Colors.white,
                colorButton: AppColors.BLUE_COLOR,
                width: 75.w,
                onTap: () {
                  navigationController.paginate(3);
                },
                height: 32.h,
                radius: 10.r,
                text: 'stores'.tr),
          ),
        ],
      ),
    );
  }
}
