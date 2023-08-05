import 'package:bnaa/controllers/client_controllers/home_controller.dart';
import 'package:bnaa/view_models/product_home_model.dart';
import 'package:bnaa/views/widgets/cards/cardProduct.dart';
import 'package:bnaa/views/widgets/line/line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:bnaa/views/client_view/client_home_page/components/client_all_products.dart';

class ProductsWidget extends StatelessWidget {
  ProductsWidget({Key? key, required this.productHomeModel}) : super(key: key);
  ProductHomeModel productHomeModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(AllProductsWidget(id: productHomeModel.category.id));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Line(
              title1: Get.locale?.languageCode == 'fr'
                  ? productHomeModel.category.nameFr.toString()
                  : productHomeModel.category.nameAr.toString(),
              title2: "",
            ),
          ),
        ),
        SizedBox(height: 15.h),
        SizedBox(
          height: 260,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            scrollDirection: Axis.horizontal,
            itemCount: productHomeModel.products.length,
            itemBuilder: (BuildContext context, int index) {
              return GetBuilder<HomeController>(builder: (context) {
                return CardProduct(
                  product: productHomeModel.products[index],
                );
              });
            },
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
