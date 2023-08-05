import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/models/order.dart';
import 'package:bnaa/views/store_view/store_details_order/store_details_order.dart';
import 'package:bnaa/views/widgets/timeLine.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/image_holder.dart';

class CommandItemWidget extends StatelessWidget {
  Order model;

  CommandItemWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => StoreDetailsOrder(command: model));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
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
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.sp,
                  width: 30.sp,
                  child: CachedNetworkImage(
                    errorWidget: (ctx, _, __) => imageHolder,
                    fit: BoxFit.cover,
                    imageUrl: model.storeLogo.toString(),
                  ),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        model.customer != null ? "${model.customer!.name}" : "",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        model.createdAt.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  etats[model.status]!,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                )
              ],
            ),
            SizedBox(height: 21.h),
            ListView.builder(
              itemCount: model.listProducts!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            model.listProducts![index].name.toString() +
                                model.listProducts![index].price.toString() +
                                " " +
                                'da'.tr,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Text(
                          model.listProducts![index].qty.toString() +
                                      " " +
                                      (Get.deviceLocale?.languageCode ==
                                  'fr'
                              ? model.listProducts![index].unitFr.toString()
                              : model.listProducts![index].unitAr.toString()),
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      height: 0.5.h,
                      child: Row(),
                      color: AppColors.INACTIVE_GREY_COLOR,
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
