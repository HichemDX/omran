import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/notification_controller.dart';
import 'package:bnaa/models/notification.dart';
import 'package:bnaa/models/order.dart';
import 'package:bnaa/views/client_view/client_notifications_page/components/emptyNotfication.dart';
import 'package:bnaa/views/widgets/appBar/appBar.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/client_controllers/client_orders_controller.dart';
import '../client_orders_page/client_order_details_page.dart';
import 'components/notification_item_widget.dart';

class ClientNotificationsPage extends StatelessWidget {
  final notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_COLOR,
      appBar: AppBarWidget(
        title: 'notifications'.tr,
        icon: 'assets/icons/return.svg',
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: notificationController.getNotifications(),
        builder: (BuildContext context,
            AsyncSnapshot<List<NotificationModel>> snapshot) {
          return GetBuilder<NotificationController>(
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
                              child: NotificationComponent(
                                  model: notificationController
                                      .notifications[index]),
                            );
                          },
                          separatorBuilder: (cx, index) {
                            return const SizedBox(height: 10);
                          },
                        );
            },
          );
        },
      ),
    );
  }

  Future<void> _onTap(ctx, index) async {
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
                            .notifications[index].storeImage
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
                                  .notifications[index].storeName
                                  .toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.BLACK_TEXT_COLOR,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          SizedBox(
                            width: 210.w,
                            child: Text(
                                Get.locale?.languageCode == 'fr'
                                    ? notificationController
                                        .notifications[index].titleFr
                                        .toString()
                                    : notificationController
                                        .notifications[index].titleAr
                                        .toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.BLACK_TEXT_COLOR,
                                )),
                          )
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
      if (notificationController.notifications[index].see == false) {
        bool res = await notificationController.markAsRead(
            idNotification: notificationController.notifications[index].id!);
        if (res) {}
      }
    });*/

    if (notificationController.notifications[index].see == false) {
      bool res = await notificationController.markAsRead(
          idNotification: notificationController.notifications[index].id!);
      if (res) {}
    }
    final commandsController = Get.put(CommandController());
    Order? order;

    try {
      Loader.show(ctx, progressIndicator: LoaderStyleWidget());
      order = await commandsController
          .getCommandById(notificationController.notifications[index].orderId!);
      Loader.hide();
    } catch (e) {
      Loader.hide();
      print(e);
      //print(t);
    }
    if (order != null) {
      Get.to(() => ClientOrderDetailsPage(command: order!));
    }
  }
}
