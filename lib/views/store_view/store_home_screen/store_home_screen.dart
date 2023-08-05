import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/store_controllers/store_home_controller.dart';
import 'package:bnaa/views/store_view/store_home_screen/components/order_list_widget.dart';
import 'package:bnaa/views/store_view/store_home_screen/components/products_list_widget.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../widgets/appBar/appBarHome.dart';

class StoreHomeScreen extends StatefulWidget {
  @override
  State<StoreHomeScreen> createState() => _StoreHomeScreenState();
}

class _StoreHomeScreenState extends State<StoreHomeScreen> {
  bool isActiveProduct = true;
  final storeHomeController = Get.put(StoreHomeController());
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHomeWidget(
        title: 'home'.tr,
        scaffoldKey: scaffoldKey,
        //storeHomeController: storeHomeController,
      ),
      body: FutureBuilder<bool>(
        future: storeHomeController.getStoreHome(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: LoaderStyleWidget());
          }
          return Column(
            children: [
              SizedBox(height: 25.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isActiveProduct = true;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .42,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 15.h , horizontal: 15.w),

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: isActiveProduct
                              ? AppColors.BLUE_COLOR
                              : AppColors.BLUE_COLOR2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          SvgPicture.asset(
                            'assets/icons/1top.svg',
                            height: 30.sp,
                            width: 30.sp,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              children: [
                                Text('${storeHomeController.products}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    )),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  'products'.tr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isActiveProduct = false;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .42,
                      padding: EdgeInsets.symmetric(vertical: 15.h , horizontal: 15.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: !isActiveProduct
                              ? AppColors.BLUE_COLOR
                              : AppColors.BLUE_COLOR2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          SvgPicture.asset(
                            'assets/icons/2top.svg',
                            height: 30.sp,
                            width: 30.sp,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              children: [
                                Text('${storeHomeController.orders}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    )),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text('orders'.tr,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 13.sp)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 25.h),
              isActiveProduct
                  ? Expanded(child: ProductListWidget())
                  : Expanded(child: OrderListWidget()),
            ],
          );
        },
      ),
    );
  }
}
