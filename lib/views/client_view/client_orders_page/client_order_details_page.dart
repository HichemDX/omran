import 'package:bnaa/controllers/client_controllers/client_orders_controller.dart';
import 'package:bnaa/helper/helper.dart';
import 'package:bnaa/helper/order.html.dart';
import 'package:bnaa/models/order.dart';
import 'package:bnaa/views/widgets/line/line.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../models/normalButtonWithBorderModel.model.dart';
import '../../widgets/appBar/appBar.dart';
import '../../widgets/buttons/normalButtonWithBorder.dart';
import '../../widgets/image_holder.dart';
import '../../widgets/timeLine.dart';

class ClientOrderDetailsPage extends StatefulWidget {
  Order command;

  ClientOrderDetailsPage({required this.command});

  @override
  State<ClientOrderDetailsPage> createState() => _ClientOrderDetailsPageState();
}

class _ClientOrderDetailsPageState extends State<ClientOrderDetailsPage> {
  final CommandController commandController = Get.find();

  _cancelOrder() async {
    Loader.show(context, progressIndicator: LoaderStyleWidget());
    await commandController.cancelOrder(widget.command.id).then((value) {
      Loader.hide();
      if (value) {
        setState(() {
          widget.command.status = 'CANCELED';
        });
      } else {
        Fluttertoast.showToast(msg: "Erreur s'est produite".tr);
      }
    });
  }

  @override
  void initState() {
    commandController.selectCommand(widget.command);
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
      body: GetBuilder<CommandController>(
        builder: (controller) {
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
                                  imageUrl: controller
                                      .selectedCommand!.storeLogo
                                      .toString(),
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
                                          controller.selectedCommand!.code
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black,
                                          )),
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            controller
                                                .selectedCommand!.storeName
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w800,
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
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'amount'.tr,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          controller.selectedCommand!.grandTotal
                                                  .toString() +
                                              'da'.tr,
                                          style: TextStyle(
                                            fontSize: 10.sp,
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
                                        color: AppColors.INACTIVE_GREY_COLOR),
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('requested on'.tr,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            )),
                                        Text(
                                            controller
                                                .selectedCommand!.createdAt
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 10.sp,
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
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        TimelineStatusPage(
                          statusKey: controller.selectedCommand!.status!,
                        ),
                        controller.selectedCommand!.status! != 'PENDING'
                            ? Container()
                            : Padding(
                                padding: EdgeInsets.only(left: 15.w),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: NormalButtonWithBorder(
                                    model: NormalButtonWithBorderModel(
                                      textFontSize: 16.sp,
                                      colorText:
                                          const Color.fromRGBO(181, 0, 0, 1),
                                      bColor:
                                          const Color.fromRGBO(181, 0, 0, 1),
                                      colorButton: Colors.white,
                                      width: 116.w,
                                      wBorder: 1.sp,
                                      onTap: () {
                                        _cancelOrder();
                                      },
                                      height: 42.h,
                                      radius: 10.r,
                                      text: 'cancel'.tr,
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  /*
              Line(title1: 'invoice'.tr, title2: ""),
               SizedBox(height: 14.h),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: Color.fromRGBO(217, 217, 217, 1)),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
                        SizedBox(
                          width: 23.w,
                        ),
                        Text(
                            'Facture_${controller.selectedCommand!.customer!.name.toString()}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                    SvgPicture.asset(
                      'assets/icons/downloadIcon.svg',
                      height: 26.sp,
                      width: 26.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              */
                  Row(
                    children: [
                      Expanded(
                          child: Line(title1: 'informations'.tr, title2: "")),
                      GestureDetector(
                        onTap: () async {
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
                            controller.selectedCommand!.code.toString(),
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
                          Text(
                            'order status'.tr,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            etats[controller.selectedCommand!.status
                                    .toString()]!
                                .tr,
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
                          Text(
                            'requested on'.tr,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            controller.selectedCommand!.createdAt.toString(),
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
                            'invoice for'.tr,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          Text("${controller.selectedCommand!.customer!.name}",
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
                      SizedBox(height: 5.h),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'phone'.tr,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            controller.selectedCommand!.customer!.phone
                                .toString(),
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
                          Text(
                            'client address'.tr,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            controller.selectedCommand!.shippingInfo!.address
                                .toString(),
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
                      SizedBox(height: 15.h),
                    ],
                  ),
                  /*
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('payment mode'.tr,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          )),
                      Text(controller.selectedCommand!.createdAt.toString(),
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
                  SizedBox(height: 5.h),
                ],
              ),
              */
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
                            controller.selectedCommand!.grandTotal.toString() +
                                ' ' +
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
                  SizedBox(height: 10.h),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.selectedCommand!.listProducts!.length,
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
                                        controller.selectedCommand!
                                            .listProducts![index].name
                                            .toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                        )),
                                    Text(
                                      /*controller.selectedCommand!
                                            .listProducts![index].qty
                                            .toString()*/
                                      "1 " +
                                          (Get.locale?.languageCode == 'fr'
                                              ? controller.selectedCommand!
                                                  .listProducts![index].unitFr
                                                  .toString()
                                              : controller.selectedCommand!
                                                  .listProducts![index].unitAr
                                                  .toString()) +
                                          " * ".tr +
                                          controller.selectedCommand!
                                              .listProducts![index].quantity!
                                              .toInt()
                                              .toString(),
                                      style: TextStyle(fontSize: 15.sp),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    '${double.parse(controller.selectedCommand!.listProducts![index].price.toString()) * double.parse(controller.selectedCommand!.listProducts![index].quantity.toString())} ' +
                                        'da'.tr,
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
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
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
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
                            controller.selectedCommand!.shippingCost
                                    .toString() +
                                ' ' +
                                'da'.tr,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
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
                        controller.selectedCommand!.grandTotal.toString() +
                            " " +
                            'da'.tr,
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
                    color: AppColors.BLUE_COLOR,
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    children: [
                      Text(
                        controller.selectedCommand!.storeName.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.BLUE_COLOR,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        controller.selectedCommand!.customer!.phone.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.BLUE_COLOR,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "${controller.selectedCommand!.shippingInfo!.wilaya} ,"
                        "${controller.selectedCommand!.shippingInfo!.commune} ,"
                        "${controller.selectedCommand!.shippingInfo!.address}",
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
    );
  }
}
