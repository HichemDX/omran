import 'package:bnaa/controllers/store_controllers/store_orders_controller.dart';
import 'package:bnaa/models/order.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';

class InputSelectStatus extends StatefulWidget {
  Order order;

  InputSelectStatus({required this.order});

  @override
  State<InputSelectStatus> createState() => _InputSelectStatusState();
}

class _InputSelectStatusState extends State<InputSelectStatus> {
  final Map<String, String> list = {
    "PENDING": 'pending'.tr,
    "PROCESSING": 'accepted'.tr,
    "PREPARED": 'charged'.tr,
    "DISPATCHED": 'on the way'.tr,
    "DELIVERED": 'delivered'.tr,
    "CANCELED": 'canceled'.tr
  };

  StoreOrdersController ordersController = Get.put(StoreOrdersController());

  _changeStatus(statusKey) async {
    Loader.show(context, progressIndicator: LoaderStyleWidget());
    await ordersController
        .changeCommandStatus(orderId: widget.order.id, status: statusKey)
        .then((value) {
      Loader.hide();
    });
  }

  late String selectedStatus;

  @override
  void initState() {
    selectedStatus = list[widget.order.status]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.BLUE_COLOR, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(8),
      child: PopupMenuButton<String>(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              selectedStatus,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              'assets/icons/upIcon.svg',
              color: Colors.white,
              height: 8.sp,
              width: 8.sp,
            ),
          ],
        ),
        onSelected: (value) {
          setState(() {
            selectedStatus = list[value]!;
          });
          _changeStatus(value);
        },
        itemBuilder: (BuildContext context) {
          return list.entries.map<PopupMenuItem<String>>((value) {
            return PopupMenuItem(child: Text(value.value), value: value.key);
          }).toList();
        },
      ),
    );
  }
}
