import 'package:bnaa/controllers/client_controllers/client_orders_controller.dart';
import 'package:bnaa/models/order.dart';
import 'package:bnaa/views/pages/commande/components/cardCommand.dart';
import 'package:bnaa/views/widgets/appBar/appBarHome.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ClientOrdersPage extends StatefulWidget {
  @override
  State<ClientOrdersPage> createState() => _ClientOrdersPageState();
}

class _ClientOrdersPageState extends State<ClientOrdersPage> {
  final commandsController = Get.put(CommandController());

  final PagingController<int, Order> _pagingController =
      PagingController(firstPageKey: 1);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async {
      List<Order> newProducts = await commandsController.getCommands(pageKey);
      if (newProducts.length < 10) {
        _pagingController.appendLastPage(newProducts);
      } else {
        _pagingController.appendPage(newProducts, pageKey + 1);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHomeWidget(
        title: 'orders'.tr,
        scaffoldKey: scaffoldKey,
      ),
      body: GetBuilder<CommandController>(
        builder: (context) {
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
                return Center(
                  child: LoaderStyleWidget(),
                );
              },
              newPageProgressIndicatorBuilder: (context) {
                return Center(child: LoaderStyleWidget());
              },
              itemBuilder: (context, item, index) {
                return CardCommand(item);
              },
            ),
          );
        },
      ),
    );
  }
}
