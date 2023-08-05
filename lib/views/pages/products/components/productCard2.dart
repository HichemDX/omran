import 'package:bnaa/models/product.dart';
import 'package:bnaa/utils/ui_helper.dart';
import 'package:bnaa/views/store_view/store_add_product/store_add_product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';

import '../../../widgets/image_holder.dart';

class ProductCard2 extends StatelessWidget {
  final Product model;
  final Function? onRefresh;

  ProductCard2({required this.model, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: GestureDetector(
        onTap: () async {
          // Get.to(() => StoreDetailsProduct(product: model));
          await Get.to(() => StoreAddProduct(product: model));
          print(model);

          onRefresh;
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: const [
              BoxShadow(
                color: AppColors.BLUE_COLOR,
                blurRadius: 1,
                offset: Offset(0, 3), // Shadow position
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CachedNetworkImage(
                    errorWidget: (ctx, _, __) => imageHolder,
                    fit: BoxFit.cover,
                    imageUrl: model.productImage.toString(),
                  ),
                ),
              ),
              Container(
                width: 1,
                color: AppColors.GREY_TEXT_COLOR,
                height: 125,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
  model.name.toString().replaceRange(0, 1, model.name.toString()[0].toUpperCase()),
  style: TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
),

                          GestureDetector(
                            onTap: () async {
                              // Get.to(StoreEditProduct(
                              //   product: model,
                              // ));
                              await Get.to(
                                () => StoreAddProduct(product: model),
                              );
                              onRefresh;
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: SvgPicture.asset(
                                  'assets/icons/edit.svg',
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 5),
                          Text(
                            "${model.price} DA / ${Get.locale?.languageCode == 'fr' ? model.unitFr ?? '' : model.unitAr ?? ''}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 5.w),
                          Text(
                            getQty(qty: model.quanititeMinimum.toString()) +
                                " " +
                                (Get.locale?.languageCode == 'fr'
                                    ? model.unitFr ?? ""
                                    : model.unitAr ?? ""),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
