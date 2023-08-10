import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/cart_controller.dart';
import 'package:bnaa/views/client_view/client_cart_page/components/product_item_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../models/cart.dart';
import '../../../widgets/image_holder.dart';

class CommandItemWidget extends StatelessWidget {
  Cart model;
  final CartController cartController = Get.find();
  double totalPrice = 0;
  bool isDeliverable;

  CommandItemWidget({
    required this.model,
    required this.isDeliverable,
  });

  @override
  Widget build(BuildContext context) {
    model.listProducts!.forEach((element) {
      totalPrice += int.parse(element.price!) * element.qtySelect!;
    });
    return Padding(
      padding: const EdgeInsets.only(bottom: 75, top: 20, right: 12, left: 12),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
              color: AppColors.BLUE_COLOR,
              blurRadius: 1,
              offset: Offset(0, 10), // Shadow position
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 25.sp,
                  width: 25.sp,
                  child: CachedNetworkImage(
                    errorWidget: (ctx, _, __) => imageHolder,
                    fit: BoxFit.cover, // OR BoxFit.fitWidth
                    alignment: FractionalOffset.topCenter,
                    imageUrl: model.storeLogo.toString(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    model.storeName.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 22.sp,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    cartController.removeCart(storeId: model.storeId);
                  },
                  child: SvgPicture.asset(
                    'assets/icons/remove.svg',
                    height: 25.sp,
                    width: 25.sp,
                  ),
                )
              ],
            ),
            SizedBox(height: 35.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: model.listProducts!.length,
              itemBuilder: (context, index) {
                print(model.listProducts![index].price!);
                totalPrice =
                    totalPrice + int.parse(model.listProducts![index].price!);
                return ProductItemWidget(
                  product: model.listProducts![index],
                  index: index,
                );
              },
            ),
            SizedBox(height: 10.h),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(244, 242, 242, 1),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'A payer'.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.sp,
                    ),
                  ),
                  Text(
                    '$totalPrice ' + 'da'.tr,
                    style: TextStyle(
                      color: AppColors.GREY_TEXT_COLOR,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              decoration: BoxDecoration(
                color: isDeliverable
                    ? Colors.greenAccent
                    : const Color.fromRGBO(207, 41, 41, 1),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'delivery'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 20.sp,
                      ),
                    ),
                    Text(
                      isDeliverable
                          ? 'disponible'.tr +
                              (cartController.deliveryPrice != 0
                                  ? " : " +
                                      cartController.deliveryPrice.toString() +
                                      "da".tr
                                  : "")
                          : 'non disponible'.tr,
                      style: TextStyle(
                        color: const Color.fromRGBO(249, 227, 227, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Total : ${totalPrice + cartController.deliveryPrice}',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Color.fromARGB(255, 127, 2, 2),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
