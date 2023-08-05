import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/models/category.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CategorySelectWidget extends StatelessWidget {
  List<Category> list;
  String hintText;
  double width;
  bool isLoading;
  Function onChange;
  int? initialValue;
  TextEditingController categoryText = TextEditingController(text: '');

  CategorySelectWidget(
      {this.initialValue,
      required this.hintText,
      required this.onChange,
      required this.list,
      required this.width,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    Category? initialCategory;
    if (initialValue != null) {
      initialCategory =
          list.where((element) => element.id == initialValue).last;
      categoryText.text = Get.locale?.languageCode == 'fr'
          ? initialCategory.nameFr!
          : initialCategory.nameAr!;
    }
    return SizedBox(
      width: width,
      child: Card(
        elevation: 0,
        color: AppColors.BACKGROUND_SEE_NOTIF_GREY_COLOR,
        child: TextFormField(
          controller: categoryText,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 12.sp,
          ),
          readOnly: true,
          enableInteractiveSelection: true,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsetsDirectional.only(top: 10.sp, start: 10.sp),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(5.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 0),
                borderRadius: BorderRadius.circular(5.r),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 0),
                borderRadius: BorderRadius.circular(5.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 0),
                borderRadius: BorderRadius.circular(5.r),
              ),
              hintText: hintText,
              suffixIcon: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 0.w,
                  end: 1.sp,
                ),
                child: PopupMenuButton<Category>(
                  initialValue: initialCategory,
                  icon: isLoading
                      ? SizedBox(
                          height: 14,
                          width: 14,
                          child: LoaderStyleWidget(
                            strokeWidth: 1.5,
                          ),
                        )
                      : SvgPicture.asset(
                          'assets/icons/upIcon.svg',
                          color: AppColors.INACTIVE_GREY_COLOR,
                          height: 7.sp,
                          width: 7.sp,
                        ),
                  onSelected: (value) {
                    categoryText.text = Get.locale?.languageCode == 'fr'
                        ? value.nameFr!
                        : value.nameAr.toString();

                    onChange(value);
                  },
                  itemBuilder: (BuildContext context) {
                    return list.map<PopupMenuItem<Category>>((value) {
                      return PopupMenuItem(
                          child: Text(Get.locale?.languageCode == 'fr'
                              ? value.nameFr!
                              : value.nameAr.toString()),
                          value: value);
                    }).toList();
                  },
                ),
              )),
        ),
      ),
    );
  }
}
