import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/models/unit.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class UnitSelectWidget extends StatelessWidget {
  List<Unit> list;
  String hintText;
  double width;
  bool isLoading;
  Function onChange;
  int? initialValue;
  TextEditingController unitText = TextEditingController(text: '');

  UnitSelectWidget(
      {this.initialValue,
      required this.hintText,
      required this.onChange,
      required this.list,
      required this.width,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    Unit? initialUnit;
    if (initialValue != null) {
      initialUnit = list.where((element) => element.id == initialValue).last;
      unitText.text = Get.locale?.languageCode == 'fr'
          ? initialUnit.nameFr!
          : initialUnit.nameAr.toString();
    }

    return Container(
      width: width,
      child: Card(
        elevation: 0,
        color: AppColors.BACKGROUND_SEE_NOTIF_GREY_COLOR,
        child: TextFormField(
          controller: unitText,
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
              suffixIcon: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 0.w,
                  end: 1.sp,
                ),
                child: PopupMenuButton<Unit>(
                  icon: isLoading
                      ? Container(
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
                  initialValue: initialUnit,
                  onSelected: (value) {
                    unitText.text = Get.locale?.languageCode == 'fr'
                        ? value.nameFr!
                        : value.nameAr.toString();
                    onChange(value);
                  },
                  itemBuilder: (BuildContext context) {
                    return list.map<PopupMenuItem<Unit>>((value) {
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
