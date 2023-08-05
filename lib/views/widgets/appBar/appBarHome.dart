import 'package:bnaa/controllers/auth/auth_controller.dart';
import 'package:bnaa/main.dart';
import 'package:bnaa/views/client_view/client_notifications_page/client_notifications_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/client_controllers/home_controller.dart';
import '../../../controllers/store_controllers/store_home_controller.dart';
import '../../store_view/store_notification_page/store_notification_page.dart';

PreferredSizeWidget appBarHomeWidget({
  required String title,
  required GlobalKey<ScaffoldState> scaffoldKey,
  // StoreHomeController? storeHomeController,
}) {
  final authController = Get.put(AuthProvider());
  final storeHomeController = Get.put(StoreHomeController());
  final clientHomeController = Get.put(HomeController());

  return AppBar(
    elevation: 0,
    backgroundColor: AppColors.BLUE_COLOR,
    leadingWidth: 43,
    centerTitle: true,
    leading: Container(
      margin: EdgeInsets.only(left: 8.0),
      child: IconButton(
        onPressed: () {
          MyApp.scaffoldKey.currentState!.openDrawer();
        },
        icon: SvgPicture.asset(
          'assets/icons/drawerIcon.svg',
          height: 28,
          width: 28,
        ),
      ),
    ),
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    actions: [
      Container(
        margin: EdgeInsets.only(right: 8.0),
        child: IconButton(
          onPressed: () async {
            bool isClient = await authController.isClient();
            if (isClient) {
              Get.to(ClientNotificationsPage());
            } else {
              Get.to(StoreNotificationsPage());
            }
          },
          icon: FutureBuilder<bool>(
            future: authController.isClient(),
            builder: (context, snapshot) {
              print(snapshot.data);
              bool isClient = snapshot.data ??
                  false; // Default to false if snapshot is null
              if (isClient) {
                return GetBuilder<HomeController>(
                  builder: (context) {
                    print("object");
                    print('object ${clientHomeController.isNotif}');
                    return SvgPicture.asset(
                      clientHomeController.isNotif
                          ? 'assets/icons/notifIcon2.svg'
                          : 'assets/icons/notifless.svg',
                      height: 28.sp,
                      width: 28.sp,
                    );
                  },
                );
              } else {
                return GetBuilder<StoreHomeController>(
                  builder: (context) {
                    return SvgPicture.asset(
                      storeHomeController.isNotif
                          ? 'assets/icons/notifIcon.svg'
                          : 'assets/icons/notifless.svg',
                      height: 20.sp,
                      width: 20.sp,
                    );
                  },
                );
              }
            },
          ),
        ),
      )
    ],
  );
}
