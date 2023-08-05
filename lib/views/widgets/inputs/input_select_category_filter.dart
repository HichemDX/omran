import 'package:bnaa/models/category.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';

class InputSelectCategoryFilter extends StatelessWidget {
  List<Category> list;
  String hintText;
  double width;
  bool isLoading;
  Function onChange;
  InputSelectCategoryFilter(
      {required this.hintText,required this.onChange, required this.list, required this.width,this.isLoading = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Card(
        elevation: 0,
        color: AppColors.BACKGROUND_SEE_NOTIF_GREY_COLOR,
        child: TextFormField(
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 12.sp,
          ),
          readOnly: true,
          enableInteractiveSelection: true,
          decoration: InputDecoration(
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
                child: PopupMenuButton<Category>(
                  icon: isLoading ? Container(height:14,width:14,child: LoaderStyleWidget(strokeWidth: 1.5,),):SvgPicture.asset(
                    'assets/icons/upIcon.svg',
                    color: AppColors.INACTIVE_GREY_COLOR,
                    height: 7.sp,
                    width: 7.sp,
                  ),
                  onSelected: (value) {
                    onChange(value);
                    },
                  itemBuilder: (BuildContext context) {
                    return list.map<PopupMenuItem<Category>>((value) {
                      return PopupMenuItem(
                          child: Text(Get.locale?.languageCode == 'fr'
                              ? value.nameFr! : value.nameAr.toString()), value: value);
                    }).toList();
                  },
                ),
              )),
        ),
      ),
    );
  }
}
