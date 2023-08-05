import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/cart_controller.dart';
import 'package:bnaa/views/client_view/client_cart_page/components/product_item_widget.dart';
import 'package:bnaa/views/client_view/client_orders_page/confirm_order_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../models/cart.dart';
import '../../../widgets/image_holder.dart';

class CartItemWidget extends StatelessWidget {
  Cart model;
  final CartController cartController = Get.find();
  double totalPrice = 0;

  CartItemWidget({required this.model});

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
          boxShadow: const [
            BoxShadow(
              color: AppColors.BLUE_COLOR,
              blurRadius: 1,
              offset: Offset(0, 10), // Shadow position
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 25.sp,
                  width: 25.sp,
                  child:  CachedNetworkImage(
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
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 18.sp,
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
                    height: 18.sp,
                    width: 18.sp,
                  ),
                ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total : $totalPrice',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ElevatedButton(
                  onPressed: totalPrice == 0
                      ? null
                      : () => Get.to(
                            () => ConfirmOrderPage(cartIndex: model.storeId!),
                          ),
                  child: Text('confirm'.tr),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
