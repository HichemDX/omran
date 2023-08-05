import 'package:bnaa/models/category.dart';
import 'package:bnaa/views/widgets/cards/cardCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../view_models/product_home_model.dart';

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget(
      {Key? key, required this.categories, required this.productHomeModel})
      : super(key: key);
  final List<ProductHomeModel> productHomeModel;

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.sp,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 5.w,),
        itemBuilder: (BuildContext context, int index) {
          print(categories[index].icon);
          return InkWell(
            child: CardCategory(
              model: categories[index],
            ),
          );
        },
      ),
    );
  }
}
