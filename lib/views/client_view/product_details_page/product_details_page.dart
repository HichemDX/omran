import 'dart:developer';

import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/cart_controller.dart';
import 'package:bnaa/controllers/client_controllers/store_details_controller.dart';
import 'package:bnaa/models/product.dart';
import 'package:bnaa/models/store.dart';
import 'package:bnaa/utils/ui_helper.dart';
import 'package:bnaa/views/client_view/client_store_details_page/client_store_details_page.dart';
import 'package:bnaa/views/dialogs/InputAlert.dart';
import 'package:bnaa/views/store_view/store_add_product/components/image_file_carousel.dart';
import 'package:bnaa/views/widgets/image_holder.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProductDetailsPage extends StatefulWidget {
  Product product;
  bool type;

  ProductDetailsPage({required this.type, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final CartController cartController = Get.find();

  late num count;

  bool isAddedToCart = false;

  @override
  void initState() {
    count = widget.product.quanititeMinimum!;
    super.initState();
  }

  getInfoStor() async {
    Loader.show(context, progressIndicator: LoaderStyleWidget());

    final storeController = Get.put(StoreController());
    Store result =
        await storeController.getStoreDetails(widget.product.storeId);
    Get.to(ClientStoreDetailsPage(store: result));
    Loader.hide();
  }

  @override
  Widget build(BuildContext context) {
    log("imageFiles : : : :  ${widget.product.productImage}");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.BLUE_COLOR,
        leadingWidth: 30,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'product details'.tr,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            widget.product.images!.isNotEmpty
                ? ImageFilesCarousel(
                    listImages: widget.product.images!,
                  )
                : Padding(
                    padding: EdgeInsets.all(12.sp),
                    child:
                        SizedBox(height: 250, width: 250, child: imageHolder),
                  ),
            SizedBox(height: 5.h),
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: contentValue(
                            key: 'product name'.tr,
                            value: "${widget.product.name} "),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: contentValue(
                            key: 'unit of measure'.tr,
                            value:
                                "${getValueLang(valFr: widget.product.unitFr ?? "", valAr: widget.product.unitAr ?? "")} "),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: contentValue(
                            key: 'category'.tr,
                            value:
                                "${getValueLang(valFr: widget.product.categoryFr ?? "", valAr: widget.product.categoryAr ?? "")} "),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: contentValue(
                            key: 'minimum quantity'.tr,
                            value: getQty(
                                qty: "${widget.product.quanititeMinimum}")),
                      ),
                      /*
                      const SizedBox(width: 5),
                      Expanded(
                        child: contentValue(
                            key: 'Quantity'.tr,
                            value: getQty(qty: "${widget.product.qty}")),
                      ),
                      */
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: contentValue(
                          key: 'unit price'.tr,
                          value: getQty(qty: "${widget.product.price}"),
                          asset: 'assets/icons/moneyIcon.svg',
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: widget.type
                            ? Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: StatefulBuilder(
                                    builder: (context, StateSetter setState) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        child: SvgPicture.asset(
                                          'assets/icons/minusIcon.svg',
                                          height: 30,
                                          width: 30,
                                        ),
                                        onTap: () {
                                          if (count > 0) {
                                            if (count >
                                                widget.product
                                                    .quanititeMinimum!) {
                                              setState(() {
                                                count--;
                                              });
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: 'Quantité min est'.tr +
                                                      '${widget.product.quanititeMinimum}');
                                            }
                                          }
                                        },
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog<void>(
                                              context: context,
                                              barrierDismissible:
                                                  false, // user must tap button!
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(32.0),
                                                    ),
                                                  ),
                                                  content: InputAlert(
                                                      "select qnt".tr,
                                                      initValue: count,
                                                      inputType:
                                                          TextInputType.number,
                                                      onSubmit: (val) {
                                                    double? result =
                                                        double.tryParse(val);
                                                    setState(() {
                                                      count = result != null &&
                                                              result >=
                                                                  widget.product
                                                                      .quanititeMinimum!
                                                          ? result
                                                          : count;
                                                    });
                                                  }),
                                                );
                                              });
                                        },
                                        child: Text(getQty(qty: "$count")),
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            count++;
                                          });
                                        },
                                        child: SvgPicture.asset(
                                          'assets/icons/plusIcons.svg',
                                          height: 30,
                                          width: 30,
                                        ),
                                      )
                                    ],
                                  );
                                }),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  contentValue(
                      key: 'description'.tr, value: "${widget.product.desc}"),
                  SizedBox(height: 20.h),
                  // GestureDetector(
                  //   onTap: () {
                  //     getInfoStor();
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         color: const Color.fromRGBO(52, 103, 128, 1)
                  //             .withOpacity(.2),
                  //         border: const Border(
                  //           bottom: BorderSide(
                  //               color: Color.fromRGBO(52, 103, 128, 1),
                  //               width: 1),
                  //         )),
                  //     child: Row(
                  //       children: [
                  //         SizedBox(
                  //           height: 50,
                  //           width: 50,
                  //           child: CachedNetworkImage(
                  //             errorWidget: (ctx, _, __) => imageHolder,
                  //             imageUrl: "${widget.product.storeImage}",
                  //             fit: BoxFit.cover,
                  //           ),
                  //         ),
                  //         SizedBox(width: 28.w),
                  //         Expanded(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "${widget.product.storeName}",
                  //                 style: TextStyle(
                  //                   color: AppColors.BLACK_TEXT_COLOR,
                  //                   fontSize: 26.sp,
                  //                   fontWeight: FontWeight.bold,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  SizedBox(height: 18.54.h),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: widget.type
          ? null
          : Padding(
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
      bottomNavigationBar: widget.type
          ? StatefulBuilder(
              builder: (context, StateSetter setState) {
                if (isAddedToCart) {
                  return Container(
                    color: AppColors.BLUE_COLOR,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Done".tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  );
                }
                return InkWell(
                  onTap: () async {
                    widget.product.qtySelect = count;
                    await cartController.addToCart(
                      storeId: '${widget.product.storeId}',
                      storeName: '${widget.product.storeName}',
                      storeImage: '${widget.product.storeImage}',
                      product: widget.product,
                    );

                    setState(() {
                      isAddedToCart = true;
                    });
                    await Future.delayed(const Duration(seconds: 3));
                    setState(() => isAddedToCart = false);
                  },
                  child: Container(
                    color: AppColors.BLUE_COLOR,
                    height: 50.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'add'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        SvgPicture.asset(
                          'assets/icons/shopIcon.svg',
                          height: 25.sp,
                          width: 25.sp,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : null,
    );
  }

  Widget contentValue({
    required String key,
    required String value,
    IconData? icon,
    String? asset,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          key,
          style: TextStyle(
            color: AppColors.BLUE_COLOR,
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) Icon(icon),
              if (asset != null)
                SvgPicture.asset(
                  asset,
                  width: 20,
                ),
              if (icon != null || asset != null)
                const SizedBox(
                  width: 10,
                ),
              Expanded(child: Text(value, overflow: TextOverflow.clip)),
            ],
          ),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(52, 103, 128, 1).withOpacity(.2),
              border: const Border(
                bottom: BorderSide(
                    color: Color.fromRGBO(52, 103, 128, 1), width: 1),
              )),
        ),
      ],
    );
  }
}
