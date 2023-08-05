import 'package:bnaa/controllers/store_controllers/store_orders_controller.dart';
import 'package:bnaa/models/order.dart';
import 'package:bnaa/views/store_view/commands/components/command_item_widget.dart';
import 'package:bnaa/views/store_view/commands/components/status_linear_widget.dart';
import 'package:bnaa/views/widgets/appBar/appBarHome.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommandsScreen extends StatelessWidget {
  final ordersController = Get.put(StoreOrdersController());
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHomeWidget(
        scaffoldKey: scaffoldKey,
        title: 'orders'.tr,
      ),
      body: FutureBuilder<List<Order>>(
          future: ordersController.getStoreCommands(),
          builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
            if (snapshot.hasData) {
              return Column(children: [
                SizedBox(height: 25.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: StatusLinearWidget(),
                ),
                SizedBox(height: 14.h),
                Expanded(
                  child: GetBuilder<StoreOrdersController>(
                    builder: (_) {
                      if (ordersController.isLoading) {
                        return Center(
                          child: LoaderStyleWidget(),
                        );
                      }
                      if (ordersController.commands.isEmpty) {
                        return Center(
                          child: Text('no orders to show'.tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: Colors.black,
                              )),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.only(bottom: 70.h),
                        shrinkWrap: true,
                        itemCount: ordersController.commands.length,
                        itemBuilder: (ctx, index) {
                          print(ordersController.commands[index].id);
                          return CommandItemWidget(
                            ordersController.commands[index],
                          );
                        },
                      );
                    },
                  ),
                )
              ]);
            }
            return Center(
              child: LoaderStyleWidget(),
            );
          }),
    );
  }
}
