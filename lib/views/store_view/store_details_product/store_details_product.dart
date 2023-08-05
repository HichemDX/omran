import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/store_controllers/store_products_controller.dart';
import 'package:bnaa/models/product.dart';
import 'package:bnaa/views/widgets/carousel/carouselDetailProduct.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/image_holder.dart';

class StoreDetailsProduct extends StatefulWidget {
  Product product;

  StoreDetailsProduct({required this.product});

  @override
  State<StoreDetailsProduct> createState() => _StoreDetailsProductState();
}

class _StoreDetailsProductState extends State<StoreDetailsProduct> {
  @override
  StoreProductsController storeProductsController = Get.find();

  _deleteProduct() {
    Loader.show(context, progressIndicator: LoaderStyleWidget());
    storeProductsController
        .deleteProduct(productId: widget.product.id)
        .then((value) {
      Loader.hide();
      if (value) {
        Get.back();
      }
    });
  }

  @override
  void initState() {
    storeProductsController.selectProduct(widget.product);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.BLUE_COLOR,
        leadingWidth: 30,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _deleteProduct,
            icon: SvgPicture.asset(
              'assets/icons/trashIcon.svg',
              height: 20.sp,
              width: 20.sp,
            ),
          )
        ],
        title: Text(
          'details'.tr,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<StoreProductsController>(
          builder: (_) {
            print("details");
            print(storeProductsController.selectedProduct!.images?.length);
            return Column(
              children: [
                storeProductsController.selectedProduct!.images!.isNotEmpty
                    ? CarouselDetailsProduct(
                        sliderModel:
                            storeProductsController.selectedProduct!.images,
                      )
                    : imageHolder,
                SizedBox(height: 5.h),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: const BoxDecoration(color: AppColors.BLUE_COLOR),
                  child: Text(
                    storeProductsController.selectedProduct!.name.toString(),
                    style: TextStyle(
                      fontSize: 30.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                Text(
                  storeProductsController.selectedProduct!.desc.toString(),
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 24.h),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'unit of measure'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            Get.locale?.languageCode == 'fr'
                                ? storeProductsController
                                    .selectedProduct!.unitFr
                                    .toString()
                                : storeProductsController
                                    .selectedProduct!.unitAr
                                    .toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        height: 1.h,
                        color: AppColors.GREY_TEXT_COLOR,
                        width: double.infinity,
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'minimum quantity'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            storeProductsController
                                    .selectedProduct!.quanititeMinimum
                                    .toString() +
                                " " +
                                storeProductsController.selectedProduct!.unitFr
                                    .toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        height: 1.h,
                        color: AppColors.GREY_TEXT_COLOR,
                        width: double.infinity,
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'quantity in stock'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            storeProductsController.selectedProduct!.qty
                                .toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        height: 1.h,
                        color: AppColors.GREY_TEXT_COLOR,
                        width: double.infinity,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/moneyIcon.svg',
                                height: 18.sp,
                                width: 18.sp,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                  storeProductsController.selectedProduct!.price
                                          .toString() +
                                      " " +
                                      'da'.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50)
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 5.h, right: 10.w),
        child: Container(
          height: 50.sp,
          width: 50.sp,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.BLUE_COLOR,
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/edit.svg',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
