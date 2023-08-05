import 'dart:developer';

import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/store_controllers/store_orders_controller.dart';
import 'package:bnaa/helper/helper.dart';
import 'package:bnaa/helper/order.html.dart';
import 'package:bnaa/models/order.dart';
import 'package:bnaa/views/widgets/appBar/appBar.dart';
import 'package:bnaa/views/widgets/inputs/input_select_status.dart';
import 'package:bnaa/views/widgets/line/line.dart';
import 'package:bnaa/views/widgets/timeLine.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/image_holder.dart';

class StoreDetailsOrder extends StatefulWidget {
  Order command;

  StoreDetailsOrder({Key? key, required this.command}) : super(key: key);

  @override
  _StoreDetailsOrderState createState() => _StoreDetailsOrderState();
}

class _StoreDetailsOrderState extends State<StoreDetailsOrder> {
  StoreOrdersController ordersController = Get.put(StoreOrdersController());

  @override
  void initState() {
    print(widget.command.id);
    ordersController.commands.forEach((element) {
      print(element.id);
    });
    try {
      ordersController.selectCommand(widget.command.id);
    } catch (e) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_COLOR,
      appBar: AppBarWidget(
        title: 'order details'.tr,
        icon: 'assets/icons/return.svg',
      ),
      body: GetBuilder<StoreOrdersController>(
        builder: (_) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: Column(
                children: [
                  Container(
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12.sp),
                              child: SizedBox(
                                height: 100.sp,
                                width: 100.sp,
                                child: CachedNetworkImage(
                                  errorWidget: (ctx, _, __) => imageHolder,
                                  fit: BoxFit.cover,
                                  imageUrl: widget.command.storeLogo.toString(),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        widget.command.code.toString(),
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.command.storeName.toString(),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2.h),
                                    Container(
                                        height: 0.5.h,
                                        width: double.infinity,
                                        color: AppColors.INACTIVE_GREY_COLOR),
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('amount'.tr,
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            )),
                                        Text(
                                          widget.command.grandTotal.toString() +
                                              " " +
                                              'da'.tr,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('requested on'.tr,
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            )),
                                        Text(
                                            widget.command.createdAt.toString(),
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ))
                                      ],
                                    ),
                                    SizedBox(height: 2.h),
                                    Container(
                                      height: 0.5.h,
                                      width: double.infinity,
                                      color: AppColors.INACTIVE_GREY_COLOR,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        TimelineStatusPage(
                          statusKey: widget.command.status!,
                        ),
                      ],
                    ),
                  ),
                  /*SizedBox(height: 20.h),
                  Line(title1: 'invoice'.tr, title2: ""),
                  SizedBox(height: 14.h),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: const Color.fromRGBO(217, 217, 217, 1),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/pdfIcon.svg',
                              height: 26.sp,
                              width: 26.sp,
                            ),
                            SizedBox(width: 23.w),
                            Text(
                              'Facture_${widget.command.customer?.name.toString()}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        SvgPicture.asset(
                          'assets/icons/downloadIcon.svg',
                          height: 26.sp,
                          width: 26.sp,
                        ),
                      ],
                    ),
                  ),*/
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                          child: Line(title1: 'informations'.tr, title2: "")),
                      GestureDetector(
                        onTap: () async {
                          log("message");
                          await printFileAsPdf(
                              "omran-order-" + DateTime.now().toString(),
                              await getFormatHtml(
                                context: context,
                                command: widget.command,
                              ),
                              context);
                        },
                        child: Icon(
                          Icons.print,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'order code'.tr,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.command.code.toString(),
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        height: 0.5.h,
                        width: double.infinity,
                        color: AppColors.INACTIVE_GREY_COLOR,
                      ),
                      SizedBox(height: 5.h),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('order status'.tr,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              )),
                          Text(
                            etats[widget.command.status]!.tr,
                            style: TextStyle(
                              fontSize: 15.sp,
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
                          color: AppColors.INACTIVE_GREY_COLOR),
                      SizedBox(height: 5.h),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('requested on'.tr,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              )),
                          Text(widget.command.createdAt.toString(),
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ))
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Container(
                          height: 0.5.h,
                          width: double.infinity,
                          color: AppColors.INACTIVE_GREY_COLOR),
                      SizedBox(height: 10.h),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('invoice for'.tr,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              )),
                          Text(
                            "${widget.command.customer!.name}",
                            style: TextStyle(
                              fontSize: 15.sp,
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
                          color: AppColors.INACTIVE_GREY_COLOR),
                      SizedBox(height: 5.h),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('phone'.tr,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              )),
                          Text(
                            widget.command.customer!.phone.toString(),
                            style: TextStyle(
                              fontSize: 15.sp,
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
                      SizedBox(height: 5.h),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('client address'.tr,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              )),
                          Text(widget.command.shippingInfo!.address.toString(),
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ))
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Container(
                          height: 0.5.h,
                          width: double.infinity,
                          color: AppColors.INACTIVE_GREY_COLOR),
                      SizedBox(height: 10.h),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'amount to pay'.tr,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.command.grandTotal.toString() +
                                " " +
                                'da'.tr,
                            style: TextStyle(
                              fontSize: 15.sp,
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
                    ],
                  ),
                  SizedBox(height: 20.h),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: widget.command.listProducts!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.command.listProducts![index].name
                                          .toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 15.sp),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "1 " +
                                              (Get.locale?.languageCode == 'fr'
                                                  ? widget
                                                      .command
                                                      .listProducts![index]
                                                      .unitFr
                                                      .toString()
                                                  : widget
                                                      .command
                                                      .listProducts![index]
                                                      .unitAr
                                                      .toString()) +
                                              " X "
                                          /* widget.command.listProducts![index]
                                                  .quantity!
                                                  .toInt()
                                                  .toString()*/
                                          ,
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                        const SizedBox(width: 1),
                                        Text(
                                          widget.command.listProducts![index]
                                              .quantity!
                                              .toInt()
                                              .toString(),
                                          style: TextStyle(fontSize: 15.sp),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    '${double.parse(widget.command.listProducts![index].price.toString()) * double.parse(widget.command.listProducts![index].quantity.toString())} ' +
                                        'da'.tr,
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
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
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'delivery'.tr,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.command.shippingCost.toString() +
                                " " +
                                'da'.tr,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    height: 2.h,
                    width: double.infinity,
                    color: AppColors.BLUE_COLOR,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'total'.tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.BLUE_COLOR,
                        ),
                      ),
                      SizedBox(width: 30.w),
                      Text(
                        widget.command.grandTotal.toString() + " " + "da".tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.BLUE_COLOR,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Container(
                      height: 2.h,
                      width: double.infinity,
                      color: AppColors.BLUE_COLOR),
                  SizedBox(height: 10.h),
                  Column(
                    children: [
                      Text(
                        widget.command.storeName.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.BLUE_COLOR,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        widget.command.customer!.phone.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.BLUE_COLOR,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "${widget.command.shippingInfo!.wilaya} ,"
                        "${widget.command.shippingInfo!.commune} ,"
                        "${widget.command.shippingInfo!.address}",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.BLUE_COLOR,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('total'.tr),
                Text('${widget.command.grandTotal} ' + 'da'.tr)
              ],
            ),
            GetBuilder<StoreOrdersController>(
              builder: (_) {
                return InputSelectStatus(
                  order: widget.command,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
