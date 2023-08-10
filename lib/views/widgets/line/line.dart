import 'package:bnaa/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Line extends StatelessWidget {
  String title1;
  String title2;

  Line({required this.title1, required this.title2});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(end: 10.w),
          child: Text(
            title1,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20.sp,
              color: AppColors.BLUE_COLOR,
              fontWeight: FontWeight.bold, 
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            color: AppColors.BLUE_COLOR,
            height: 2.h,
          ),
        ),
        const SizedBox(width: 8),
        title2 != ''
            ? Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Text(
                  title2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.BLUE_COLOR,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
