import 'package:bnaa/models/plusButtonModel.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PlusButton extends StatelessWidget {
  PlusButtonModel model;
  PlusButton({required this.model});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
          height: model.height,
          width: model.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                model.icon,
                height: 56.sp,
                width: 56.sp,
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(model.text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: model.colorText,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp)),
              )
            ],
          ),
          decoration: BoxDecoration(
              color: model.colorBackground,
              borderRadius: BorderRadius.circular(model.radius)),
        ));
  }
}
