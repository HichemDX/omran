import 'package:bnaa/models/wilaya.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';

class InputSelectWilayaStoreFilter extends StatefulWidget {
  List<Wilaya> list;
  String hintText;
  double width;
  bool isLoading;
  Function? onSelected;
  String? initValue;

  InputSelectWilayaStoreFilter(
      {Key? key,
      required this.hintText,
      this.initValue,
      this.onSelected,
      required this.list,
      required this.width,
      this.isLoading = false})
      : super(key: key);

  @override
  State<InputSelectWilayaStoreFilter> createState() =>
      _InputSelectWilayaStoreFilterState();
}

class _InputSelectWilayaStoreFilterState
    extends State<InputSelectWilayaStoreFilter> {
  TextEditingController? wilayaController;

  @override
  void initState() {
    super.initState();
    if (widget.initValue != null) {
      wilayaController = TextEditingController(text: widget.initValue);
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
          controller: wilayaController,
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
            hintText: widget.hintText,
            suffixIcon: Padding(
              padding: EdgeInsets.only(
                left: 0.w,
                right: 1.sp,
              ),
              child: PopupMenuButton<Wilaya>(
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
                  if (widget.initValue != null) {
                    wilayaController?.text = Get.locale?.languageCode == 'fr'
                        ? value.nameFr!
                        : value.nameAr.toString();
                  }
                  widget.hintText = Get.locale?.languageCode == 'fr'
                      ? value.nameFr!
                      : value.nameAr.toString();
                  setState(() {});
                  widget.onSelected!(value);
                },
                itemBuilder: (BuildContext context) {
                  return widget.list.map<PopupMenuItem<Wilaya>>(
                    (value) {
                      return PopupMenuItem(
                        child: Text(Get.locale?.languageCode == 'fr'
                            ? value.nameFr!
                            : value.nameAr.toString()),
                        value: value,
                      );
                    },
                  ).toList();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
