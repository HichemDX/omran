import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/store_controllers/store_orders_controller.dart';

import 'package:bnaa/views/client_view/client_notifications_page/components/emptyNotfication.dart';
import 'package:bnaa/views/store_view/store_details_order/store_details_order.dart';
import 'package:bnaa/views/widgets/appBar/appBar.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/store_controllers/store_notifications_controller.dart';
import '../../../models/order.dart';
import '../../../models/store_notification.dart';

import 'components/store_notification_item.dart';

class StoreNotificationsPage extends StatelessWidget {
  final notificationController = Get.put(StoreNotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_COLOR,
      appBar: AppBarWidget(
        title: 'notifications'.tr,
        icon: 'assets/icons/return.svg',
      ),
      body: FutureBuilder<List<StoreNotificationModel>>(
        future: notificationController.getNotifications(),
        builder: (context, snapshot) {
          return GetBuilder<StoreNotificationController>(
            builder: (context) {
              return notificationController.isLoading
                  ? Center(child: LoaderStyleWidget())
                  : notificationController.notifications.isEmpty
                      ? Center(child: EmptyNotification())
                      : ListView.separated(
                          padding: EdgeInsets.all(15.h),
                          itemCount:
                              notificationController.notifications.length,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () => _onTap(ctx, index),
                              child: StoreNotificationComponent(
                                model:
                                    notificationController.notifications[index],
                              ),
                            );
                          },
                          separatorBuilder: (ctx, index) =>
                              const SizedBox(height: 10),
                        );
            },
          );
        },
      ),
    );
  }

  void _onTap(ctx, index) async {
    if (notificationController.notifications[index].read == "0") {
      bool res = await notificationController.markAsRead(
          idNotification: notificationController.notifications[index].id!);
      if (res) {}
    }

    final orderController = Get.put(StoreOrdersController());

    Order? order;

    try {
      Loader.show(ctx, progressIndicator: LoaderStyleWidget());
      order = await orderController.getStoreCommandById(
          notificationController.notifications[index].orderId!);
      Loader.hide();
    } catch (e, t) {
      Loader.hide();
      print(e);
      print(t);
    }
    if (order != null) {
      Get.to(() => StoreDetailsOrder(command: order!));
    }
    /*showDialog(
      context: ctx,
      builder: (cx) {
        return AlertDialog(
          content: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 50.sp,
                      height: 50.sp,
                      child: CachedNetworkImage(
                        errorWidget: (ctx, _, __) => imageHolder,
                        imageUrl: notificationController
                            .notifications[index].customer!.image
                            .toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 210.w,
                            child: Text(
                              notificationController
                                  .notifications[index].customer!.name
                                  .toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.BLACK_TEXT_COLOR,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          SizedBox(
                            width: 210.w,
                            child: Text(
                              Get.locale?.languageCode == 'fr'
                                  ? notificationController
                                      .notifications[index].nameFr
                                      .toString()
                                  : notificationController
                                      .notifications[index].nameAr
                                      .toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.BLACK_TEXT_COLOR,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  Get.locale?.languageCode == 'fr'
                      ? notificationController
                          .notifications[index].descriptionFr
                          .toString()
                      : notificationController
                          .notifications[index].descriptionAr
                          .toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.BLACK_TEXT_COLOR,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) async {
      if (notificationController.notifications[index].read == "0") {
        bool res = await notificationController.markAsRead(
            idNotification: notificationController.notifications[index].id!);
        if (res) {}
      }
    });*/
  }
}
