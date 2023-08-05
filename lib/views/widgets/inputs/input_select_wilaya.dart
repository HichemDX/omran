import 'package:bnaa/controllers/commune_select_controller.dart';
import 'package:bnaa/models/wilaya.dart';
import 'package:bnaa/utils/validate.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';

class InputSelectWilaya extends StatelessWidget {
  List<Wilaya> list;
  String hintText;
  double width;
  bool isLoading;
  Function onChange;

  TextEditingController wilayaController = TextEditingController(text: '');
  final CommuneSelectController communeSelectController = Get.find();

  InputSelectWilaya(
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
        controller: wilayaController,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 12.sp,
        ),
        readOnly: true,
        enableInteractiveSelection: true,
        validator: (value) {
          return Validate.requiredField(value!, 'Selectionner la Wilaya');
        },
        decoration: InputDecoration(
            errorStyle: TextStyle(
              fontSize: 8.0,
            ),
            contentPadding: EdgeInsets.all(8),
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
              padding: EdgeInsets.only(
                left: 0.w,
                right: 1.sp,
              ),
              child: PopupMenuButton<Wilaya>(
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

                  wilayaController.text = Get.locale?.languageCode == 'fr'
                      ? value.nameFr! : value.nameAr.toString();
                  communeSelectController.getCommunes(value.id);
                },
                itemBuilder: (BuildContext context) {
                  return list.map<PopupMenuItem<Wilaya>>((value) {
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
