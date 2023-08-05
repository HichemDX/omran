import 'package:bnaa/controllers/store_controllers/store_orders_controller.dart';
import 'package:bnaa/models/order.dart';
import 'package:bnaa/views/store_view/commands/components/command_item_widget.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class OrderListWidget extends StatefulWidget {
  OrderListWidget({Key? key}) : super(key: key);

  @override
  State<OrderListWidget> createState() => _OrderListWidgetState();
}

class _OrderListWidgetState extends State<OrderListWidget> {
  final ordersController = Get.put(StoreOrdersController());

  final PagingController<int, Order> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async {
      List<Order> newOrders =
          await ordersController.getStoreCommands(page: pageKey);
      if (newOrders.length < 50) {
        _pagingController.appendLastPage(newOrders);
      } else {
        _pagingController.appendPage(newOrders, pageKey + 1);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Order>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Order>(
        noItemsFoundIndicatorBuilder: (context) {
          return Center(
            child: Text(
              'no orders to show'.tr,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ),
          );
        },
        firstPageProgressIndicatorBuilder: (context) {
          return Center(child: LoaderStyleWidget());
        },
        newPageProgressIndicatorBuilder: (context) {
          return Center(child: LoaderStyleWidget());
        },
        itemBuilder: (context, item, index) {
          return GetBuilder<StoreOrdersController>(
            builder: (context) {
              return CommandItemWidget(item);
            }
          );
        },
      ),
    );
  }
}
