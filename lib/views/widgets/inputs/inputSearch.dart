import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/views/client_view/search_page/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class InputSearch extends StatelessWidget {
  bool enabled;
  InputSearch({required this.enabled});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: (){
          Get.to(SearchPage());
        },
        child: IgnorePointer(
          child: TextFormField(
            enabled: enabled,
            style: TextStyle(
              fontSize: 15.sp,
            ),
            decoration: InputDecoration(
              hintText: 'search'.tr,
              suffixIcon: Row(mainAxisSize: MainAxisSize.min, children: [
                SvgPicture.asset('assets/icons/arrow.svg'),
                SizedBox(
                  width: 10.w,
                ),
                SvgPicture.asset('assets/icons/FilterIcon.svg')
              ]),
              prefixIconConstraints: BoxConstraints(
                maxHeight: 40.sp,
                maxWidth: 40.sp,
                minHeight: 16.sp,
                minWidth: 16.sp,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: SvgPicture.asset(
                  'assets/icons/searchIcon.svg',
                  height: 16.sp,
                  width: 16.sp,
                ),
              ),
              hintStyle: TextStyle(
                fontSize: 12.sp,
              ),
              constraints: BoxConstraints(maxHeight: (50.h).h),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(5.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.BLUE_COLOR, width: 0.4.sp),
                borderRadius: BorderRadius.circular(5.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(5.r),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
