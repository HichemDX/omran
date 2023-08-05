import 'dart:developer';

import 'package:bnaa/controllers/cart_controller.dart';
import 'package:bnaa/views/client_view/client_cart_page/chariotScreenEmpty.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

import '../../widgets/appBar/appBarHome.dart';
import 'components/cart_item_widget.dart';

class ChariotScreen extends StatelessWidget {
  final CartController cartController = Get.find();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*    bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 65.h),
        child: Container(
          color: Colors.white,
          height: 70.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text('Total :'), Text('1 5000 Da')],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: NormalButton(
                      model: NormalButtomModel(
                          textFontSize: 16.sp,
                          colorText: Colors.white,
                          colorButton: AppColors.BLUE_COLOR,
                          width: 110.w,
                          onTap: () {},
                          height: 42.h,
                          radius: 10.r,
                          text: 'save'.tr),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    */
      appBar: appBarHomeWidget(
        scaffoldKey: scaffoldKey,
        title: 'cart'.tr,
      ),
      body: SafeArea(
        child: FutureBuilder<bool>(
            future: cartController.loadFromStorage(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                return GetBuilder<CartController>(
                  builder: (_) {
                    if (cartController.cartsMap.isNotEmpty) {
                      return ListView.builder(
                        itemCount: cartController.cartsMap.length,
                        itemBuilder: (context, index) {
                          log("cart item :::: ${cartController.cartsMap.values.elementAt(index).toJson()}");
                          return CartItemWidget(
                            model:
                                cartController.cartsMap.values.elementAt(index),
                          );
                        },
                      );
                    } else {
                      return CharioScreenEmpty();
                    }
                  },
                );
              } else {
                return Center(child: LoaderStyleWidget());
              }
            }),
      ),
    );
  }
}
