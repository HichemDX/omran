import 'package:bnaa/models/commune.dart';
import 'package:bnaa/utils/validate.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';

class InputSelectCommune extends StatelessWidget {
  List<Commune> list;
  String hintText;
  double width;
  bool isLoading;
  Function onChange;

  TextEditingController communeController = TextEditingController(text: '');
  InputSelectCommune(
      {required this.hintText,
      required this.list,
      required this.width,
      required this.onChange,
      this.isLoading = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextFormField(
        controller: communeController,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 12.sp,
        ),
        readOnly: true,
        enableInteractiveSelection: true,
        validator: (value) {
          return Validate.requiredField(value!, 'Selectionner la wilaya');
        },
        decoration: InputDecoration(
            errorStyle: const TextStyle(
              fontSize: 8.0,
            ),
            contentPadding: EdgeInsets.all(8.sp),
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
              padding: EdgeInsets.only(
                left: 0.w,
                right: 1.sp,
              ),
              child: PopupMenuButton<Commune>(
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
                onSelected: (value) {
                  onChange(value);

                  communeController.text = Get.locale?.languageCode == 'fr'
                      ? value.nameFr! : value.nameAr.toString();
                },
                itemBuilder: (BuildContext context) {
                  return list.map<PopupMenuItem<Commune>>((value) {
                    return new PopupMenuItem(
                        child: new Text(Get.locale?.languageCode == 'fr'
                            ? value.nameFr! : value.nameAr.toString()), value: value);
                  }).toList();
                },
              ),
            )),
      ),
    );
  }
}
