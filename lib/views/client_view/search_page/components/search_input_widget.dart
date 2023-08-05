import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/search_controller.dart';
import 'package:bnaa/views/client_view/search_page/filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SearchInputWidget extends StatefulWidget {
  const SearchInputWidget({Key? key}) : super(key: key);

  @override
  _SearchInputWidgetState createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends State<SearchInputWidget> {
  final SearchController searchController = Get.put(SearchController());

  void showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Filter();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: TextFormField(
        controller: searchController.word,
        onEditingComplete: () async {
          FocusManager.instance.primaryFocus?.unfocus();
          searchController.getResult();
        },
        style: TextStyle(fontSize: 15.sp),
        decoration: InputDecoration(
          hintText: 'search'.tr,
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/icons/arrow.svg'),
              SizedBox(width: 10.w),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    showBottomSheet();
                  },
                  child: SvgPicture.asset('assets/icons/FilterIcon.svg'),
                ),
              ),
            ],
          ),
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
          hintStyle: TextStyle(fontSize: 12.sp),
          constraints: BoxConstraints(maxHeight: (50.h).h),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.BLUE_COLOR, width: 0.4.sp),
            borderRadius: BorderRadius.circular(5.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
      ),
    );
  }
}
