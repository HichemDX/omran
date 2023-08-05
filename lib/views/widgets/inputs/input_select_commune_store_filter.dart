import 'package:bnaa/models/commune.dart';
import 'package:bnaa/utils/validate.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';

class InputSelectCommuneStoreFilter extends StatefulWidget {
  List<Commune> list;
  String hintText;
  double width;
  bool isLoading;
  Function? onChange;
  String? initValue;

  InputSelectCommuneStoreFilter({
    required this.hintText,
    this.onChange,
    required this.list,
    required this.width,
    this.initValue,
    this.isLoading = false,
  });

  @override
  State<InputSelectCommuneStoreFilter> createState() =>
      _InputSelectCommuneStoreFilterState();
}

class _InputSelectCommuneStoreFilterState
    extends State<InputSelectCommuneStoreFilter> {
  TextEditingController? communeController;

  @override
  void initState() {
    super.initState();
    if (widget.initValue != null) {
      communeController = TextEditingController(text: widget.initValue);
    } else {
      communeController = TextEditingController(text: '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Card(
        elevation: 0,
        color: AppColors.BACKGROUND_SEE_NOTIF_GREY_COLOR,
        child: TextFormField(
          controller: communeController,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 12.sp,
          ),
          validator: (value) {
            if (value != null) {}
            return Validate.requiredField(value!, 'Champ obligatoire');
          },
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
            hintText: widget.hintText,
            // constraints: BoxConstraints(maxHeight: 35.h),
            suffixIcon: Padding(
              padding: EdgeInsets.only(
                left: 0.w,
                right: 1.sp,
              ),
              child: PopupMenuButton<Commune>(
                icon: widget.isLoading
                    ? SizedBox(
                        height: 14,
                        width: 14,
                        child: LoaderStyleWidget(strokeWidth: 1.5),
                      )
                    : SvgPicture.asset(
                        'assets/icons/upIcon.svg',
                        color: AppColors.INACTIVE_GREY_COLOR,
                        height: 7.sp,
                        width: 7.sp,
                      ),
                onSelected: (value) {
                  communeController!.text = Get.locale?.languageCode == 'fr'
                      ? value.nameFr!
                      : value.nameAr.toString();
                  widget.hintText = Get.locale?.languageCode == 'fr'
                      ? value.nameFr!
                      : value.nameAr.toString();
                  setState(() {});
                  widget.onChange!(value);
                },
                itemBuilder: (BuildContext context) {
                  return widget.list.map<PopupMenuItem<Commune>>((value) {
                    return PopupMenuItem(
                      child: Text(Get.locale?.languageCode == 'fr'
                          ? value.nameFr!
                          : value.nameAr.toString()),
                      value: value,
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
