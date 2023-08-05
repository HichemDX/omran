import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/store_controllers/current_store_controller.dart';
import 'package:bnaa/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoriesListWidget extends StatefulWidget {
  List<Category> categories;
  int activeId;
  Function? onChange;
  CategoriesListWidget({required this.categories, required this.activeId,this.onChange});

  @override
  State<CategoriesListWidget> createState() => _CategoriesListWidgetState();
}

class _CategoriesListWidgetState extends State<CategoriesListWidget> {
  final CurrentStoreController storeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: 1.sw,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length + 1,
        itemBuilder: (context, index) {
          if(index == 0){
           return InkWell(
              onTap: () {
                print(index);
                widget.onChange!(0);
                },
              child: Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Container(
                  decoration: BoxDecoration(
                      border: widget.activeId == 0
                          ? const Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width:
                            1.0, // This would be the width of the underline
                          ))
                          : null),
                  child: Text(
                    'all'.tr,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w300,
                      color: AppColors.BLUE_COLOR,
                    ),
                  ),
                ),
              ),
            );
          }else {
            return InkWell(
              onTap: () {
                print(index);

                widget.onChange!(index);
                },
              child: Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Container(
                  decoration: BoxDecoration(
                      border: widget.categories[index-1].id == widget.activeId
                          ? const Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width:
                            1.0, // This would be the width of the underline
                          ))
                          : null),
                  child: Text(
                    Get.deviceLocale?.languageCode == 'fr'
                        ? widget.categories[index-1].nameFr.toString() : widget.categories[index-1].nameAr.toString(),
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w300,
                      color: AppColors.BLUE_COLOR,
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
