import 'package:bnaa/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Label extends StatelessWidget {
  String title;
  Function callBack;
  Label({required this.title,required this.callBack});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.sp),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppColors.BLUE_LABEL_COLOR),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 14.sp, color: AppColors.BLUE_LABEL3_COLOR)),
            SizedBox(
              width: 5.w,
            ),
            InkWell(
              onTap: (){
                callBack();
              },
              child: SvgPicture.asset(
                'assets/icons/labelIcon.svg',
                width: 14,
                height: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
