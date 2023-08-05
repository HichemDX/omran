import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/normalButtonWithIconModel.model.dart';

class NormalButtonWithIcon extends StatelessWidget {
  NormalButtonWithIconModel model;
  NormalButtonWithIcon({required this.model});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        model.onTap();
      },
      child: Container(
        height: model.height,
        width: model.width,
        decoration: BoxDecoration(
          color: model.colorButton,
          borderRadius: BorderRadius.circular(model.radius),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 7.w,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(model.text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: model.colorText,
                      fontSize: model.textFontSize,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              SizedBox(
                width: 10.w,
              ),
              SvgPicture.asset(model.icon,
                  color: model.colorText, height: 15.sp, width: 15.sp),
            ],
          ),
        ),
      ),
    );
  }
}
