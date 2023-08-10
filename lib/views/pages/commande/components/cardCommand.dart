import 'package:bnaa/views/client_view/client_orders_page/client_order_details_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constants/app_colors.dart';
import '../../../../models/order.dart';
import '../../../widgets/image_holder.dart';

class CardCommand extends StatelessWidget {
  Order model;

  CardCommand(this.model);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: InkWell(
        onTap: () {
          Get.to(ClientOrderDetailsPage(
            command: model,
          ));
        },
        child: Container(
          height: 140.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            
            boxShadow: const [
              BoxShadow(
                color: AppColors.BLUE_COLOR,
                blurRadius: 8,
                offset: Offset(0, 3), // Shadow position
              ),
            ],
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: SizedBox(
                height: 100.sp,
                width: 100.sp,
                child: CachedNetworkImage(
                    errorWidget: (ctx, _, __) => imageHolder,
                    fit: BoxFit.cover,
                    imageUrl: model.storeLogo.toString()),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(model.storeName.toString(),
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold, 

                          color: Color.fromARGB(255, 255, 140, 0),
                        )),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text(
                          'order code'.tr,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight
                                .bold, // Ajout du style en gras (bold)
                            color: Colors.black,
                          ),
                        ),

                        Text(
                          "#" + model.code.toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      height: 0.5.h,
                      width: double.infinity,
                      color: AppColors.INACTIVE_GREY_COLOR,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'order status'.tr,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold, 
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          model.status!.toLowerCase().tr,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      height: 0.5.h,
                      width: double.infinity,
                      color: AppColors.INACTIVE_GREY_COLOR,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'requested on'.tr,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold, 
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          model.createdAt.toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      height: 0.5.h,
                      width: double.infinity,
                      color: AppColors.INACTIVE_GREY_COLOR,
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
