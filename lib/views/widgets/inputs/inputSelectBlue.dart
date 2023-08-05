import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/app_colors.dart';

class InputSelectBlue extends StatelessWidget {
  List<String> list;
  String hintText;
  double width;
  InputSelectBlue(
      {required this.hintText, required this.list, required this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Card(
        elevation: 0,
        color: AppColors.BLUE_COLOR,
        child: TextFormField(
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: Colors.white,
          ),
          readOnly: true,
          enableInteractiveSelection: true,
          decoration: InputDecoration(
              hintStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              contentPadding: EdgeInsets.only(top: 10.sp, left: 10.sp),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(5.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0),
                borderRadius: BorderRadius.circular(5.r),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0),
                borderRadius: BorderRadius.circular(5.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0),
                borderRadius: BorderRadius.circular(5.r),
              ),
              hintText: hintText,
              constraints: BoxConstraints(maxHeight: 35.h),
              suffixIcon: Padding(
                padding: EdgeInsets.only(
                  left: 0.w,
                  right: 1.sp,
                ),
                child: PopupMenuButton<String>(
                  icon: SvgPicture.asset(
                    'assets/icons/upIcon.svg',
                    color: Colors.white,
                    height: 7.sp,
                    width: 7.sp,
                  ),
                  onSelected: (String value) {},
                  itemBuilder: (BuildContext context) {
                    return list.map<PopupMenuItem<String>>((String value) {
                      return new PopupMenuItem(
                          child: new Text(value), value: value);
                    }).toList();
                  },
                ),
              )),
        ),
      ),
    );
  }
}
