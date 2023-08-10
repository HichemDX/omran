import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/cart_controller.dart';
import 'package:bnaa/models/product.dart';
import 'package:bnaa/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProductItemWidget extends StatefulWidget {
  Product product;
  int index;

  ProductItemWidget({Key? key, required this.product, required this.index})
      : super(key: key);

  @override
  _ProductItemWidgetState createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  final CartController cartController = Get.find();

  late int qtySelect;

  @override
  void initState() {
    super.initState();
    qtySelect = widget.product.qtySelect!.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.BLUE_LABEL_COLOR,
          borderRadius: BorderRadius.circular(10.r)),
      child: Row(children: [
        InkWell(
          onTap: () {
            cartController.removeProduct(
              productIndex: widget.index,
              storeId: widget.product.storeId,
            );
          },
          child: SvgPicture.asset(
            'assets/icons/remove.svg',
            height: 20.sp,
            width: 20.sp,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.name.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Text(
                widget.product.price.toString() +
                            " " +
                            "da".tr +
                            " / " +
                            (Get.locale?.languageCode ==
                        'fr'
                    ? widget.product.unitFr.toString()
                    : widget.product.unitAr.toString()),
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  color: AppColors.GREY_TEXT_COLOR,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            print("qty min : " + widget.product.quanititeMinimum!.toString());
            if (widget.product.qtySelect! > 0) {
              if (widget.product.qtySelect! >
                  widget.product.quanititeMinimum!) {
                cartController.updateProductQantity(
                  widget.product.storeId,
                  widget.index,
                  -1,
                );
              } else {
                Fluttertoast.showToast(
                    msg: 'Quantité min est'.tr +
                        '${widget.product.quanititeMinimum}');
              }
            }
          },
          child: SvgPicture.asset('assets/icons/minusIcons.svg'),
        ),
        SizedBox(width: 5.w),
        SizedBox(
          width: 30.w,
          child: Center(
            child: Text(
              getQty(
                  qty: widget.product.qtySelect
                      .toString() /*qtySelect.toString()*/),
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(width: 5.w),
        InkWell(
          onTap: () {
            cartController.updateProductQantity(
                widget.product.storeId, widget.index, 1);
          },
          child: SvgPicture.asset('assets/icons/plusIcons.svg'),
        )
      ]),
    );
  }
}
