
import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/favorite_product_controller.dart';
import 'package:bnaa/models/product.dart';
import 'package:bnaa/views/widgets/appBar/appBar.dart';
import 'package:bnaa/views/widgets/cards/cardProduct.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ClientSavedProductPage extends StatelessWidget {
  final favoriteController = Get.put(FavoriteProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_COLOR,
      appBar: AppBarWidget(

        title: 'Enregistrés'.tr,
        icon: 'assets/icons/return.svg',
      ),
      body: FutureBuilder<List<Product>>(
        future: favoriteController.getFavoriteProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          return GetBuilder<FavoriteProductController>(
            builder: (context) {
              return favoriteController.isLoading
                  ? Center(child: LoaderStyleWidget())
                  : favoriteController.favoriteProducts.isEmpty
                      ?  Center(child: Text('no result found'.tr))
                      : Padding(
                          padding: EdgeInsets.all(30.sp),
                          child: DynamicHeightGridView(
                            shrinkWrap: false,
                            builder: (ctx, index) {
                              return Container(
                                height: 210,
                                
                                child: CardProduct(
                                  product:
                                      favoriteController.favoriteProducts[index],
                                ),
                              );
                            },
                            itemCount:
                                favoriteController.favoriteProducts.length,
                            crossAxisCount: 2,
                          ),
                        );
            },
          );
        },
      ),
    );
  }
}
