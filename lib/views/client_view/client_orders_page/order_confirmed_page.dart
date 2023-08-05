import 'dart:convert';

import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/models/normalButtonModel.model.dart';
import 'package:bnaa/views/widgets/appBar/appBar.dart';
import 'package:bnaa/views/widgets/buttons/NormalButton.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../services/api_http.dart';
import '../../widgets/alert/showAlertDialog.dart';

class OrderConfirmedPage extends StatelessWidget {
  int storeId;

  OrderConfirmedPage(this.storeId);

  final controller = Get.put(OrderConfirmedController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          title: 'Confirmation de commande'.tr,
          icon: "assets/icons/return.svg"),
      body: FutureBuilder(
        future: controller.getStoreInfo(storeId),
        builder: (context, _) {
          return controller.phone.isEmpty
              ? Center(child: LoaderStyleWidget())
              : Center(
                  child: Column(
                    children: [
                      SizedBox(height: 54.h),
                      // SvgPicture.asset(
                      //   'assets/icons/orangeIcon.svg',
                      //   height: 67.sp,
                      //   width: 67.sp,
                      // ),
                      SizedBox(height: 100.h),
                      SvgPicture.asset(
                        'assets/icons/correctIcon.svg',
                        height: 100.sp,
                        width: 100.sp,
                      ),
                      SizedBox(height: 13.h),
                      Text(
                        'Done'.tr,
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: const Color.fromRGBO(40, 167, 69, 1),
                        ),
                      ),
                      SizedBox(height: 13.h),
                      Container(
                        width: 214.w,
                        height: 1.h,
                        decoration: const BoxDecoration(
                          color: AppColors.GREY_TEXT_COLOR,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Votre commande a ete  passé avec succés'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: AppColors.BLACK_TEXT_COLOR,
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Text(
                        'Merci Pour votre confiance , votre commande sera à temps'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(87, 87, 87, 1),
                        ),
                      ),
                      SizedBox(height: 35.h),
                      NormalButton(
                        model: NormalButtomModel(
                          textFontSize: 12.sp,
                          colorText: Colors.white,
                          colorButton: AppColors.BLUE_COLOR,
                          width: 137.w,
                          onTap: () {
                            showAlertDialog(phone: controller.phone);
                          },
                          height: 42.h,
                          radius: 10.r,
                          text: 'Suivre la commande'.tr,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      InkWell(
                        onTap: () => Get.back(),
                        child: Text(
                          'Revenir au magasin'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: const Color.fromRGBO(87, 87, 87, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class OrderConfirmedController extends GetxController {
  String phone = "";

  Future getStoreInfo(int storeId) async {
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/store_info_by_id/$storeId")
          .timeout(timeOutDuration);
      print("get my info");
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        phone = jsonDecode(response.body)['phone'];
      } else {
        return Future.error("");
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return Future.error("");
    }
  }
}
