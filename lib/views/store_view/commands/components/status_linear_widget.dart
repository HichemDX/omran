import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/store_controllers/store_orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StatusLinearWidget extends StatefulWidget {
  @override
  State<StatusLinearWidget> createState() => _StatusLinearWidgetState();
}

class _StatusLinearWidgetState extends State<StatusLinearWidget> {
  final StoreOrdersController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 1.sw,
      child: GetBuilder<StoreOrdersController>(
        builder: (context) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: orderController.commandStatus.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  orderController.selectStatus(
                      orderController.commandStatus.keys.elementAt(index));
                },
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 35),
                  child: Container(
                    decoration: BoxDecoration(
                      border: orderController.statusKey ==
                              orderController.commandStatus.keys
                                  .elementAt(index)
                          ? const Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            )
                          : null,
                    ),
                    child: Text(
                      orderController.commandStatus.values.elementAt(index).tr,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w300,
                        color: AppColors.BLUE_COLOR,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
