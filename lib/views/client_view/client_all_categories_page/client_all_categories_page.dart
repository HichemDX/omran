import 'package:bnaa/controllers/all_catigories_controller.dart';
import 'package:bnaa/models/category.dart';
import 'package:bnaa/views/widgets/cards/cardCategory.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../widgets/appBar/appBar.dart';

class ClientAllCategoriesPage extends StatelessWidget {
  final allCategoriesController = Get.put(AllCategoriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_COLOR,
      appBar:
          AppBarWidget(title: 'categories'.tr, icon: 'assets/icons/return.svg'),
      body: FutureBuilder<List<Category>>(
        future: allCategoriesController.initAllCategoriesController(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.all(30.sp),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.9,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                ),
                itemCount: allCategoriesController.categories.length,
                itemBuilder: (context, index) {
                  return CardCategory2(
                    model: allCategoriesController.categories[index],
                  );
                },
              ),
            );
          } else {
            return Center(child: LoaderStyleWidget());
          }
        },
      ),
    );
  }
}
/*imageHeight: 80.sp,
fontSize: 20.sp,
imageWidth: 80.sp,
width: 80.sp,
model: categoriesList[index],
height: 90.sp,*/
