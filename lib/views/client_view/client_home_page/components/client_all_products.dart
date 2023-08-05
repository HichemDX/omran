
import 'package:bnaa/controllers/cart_controller.dart';
import 'package:bnaa/controllers/client_controllers/home_controller.dart';
import 'package:bnaa/views/widgets/appBar/appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/views/client_view/client_home_page/components/products_widget.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';

class AllProductsWidget extends StatelessWidget {
  AllProductsWidget({Key? key, required this.id}) : super(key: key);

  int? id;

  final homeController = Get.put(HomeController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_COLOR,
      appBar:
          AppBarWidget(title: 'Products'.tr, icon: 'assets/icons/return.svg'),
      body: SafeArea(
        child: FutureBuilder<bool>(
            future: homeController.initHomeController(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: homeController
                                .homeViewModel!.productsByCategories.length,
                            itemBuilder: (context, index) {
                              return ProductsWidget(
                                productHomeModel: homeController
                                    .homeViewModel!.productsByCategories[index],
                              );
                            }),
                      ]),
                );
              } else
                return Center(child: LoaderStyleWidget());
            }),
      ),
    );
  }
}
