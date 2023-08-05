import 'dart:convert';

import 'package:bnaa/views/widgets/cards/cardProduct.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/constants.dart';
import '../../../../models/product.dart';
import '../../../../services/api_http.dart';
import '../../../widgets/appBar/appBar.dart';

class ClientAllCategoryProducts extends StatelessWidget {
  int categoryId;

  final productsController = Get.put(ClientAllCategoryProductsController());

  ClientAllCategoryProducts({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_COLOR,
      appBar:
          AppBarWidget(title: 'products'.tr, icon: 'assets/icons/return.svg'),
      body: FutureBuilder(
        future: productsController.getProducts(categoryId),
        builder: (ctx, snapShot) {
          return GetBuilder<ClientAllCategoryProductsController>(
            builder: (_) => productsController.isLoading
                ? Center(child: LoaderStyleWidget())
                : productsController.products.isEmpty
                    ?  Center(child: Text('no result found'.tr))
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width * 0.5,
                          childAspectRatio: 1 / 1.3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: productsController.products.length,
                        itemBuilder: (context, index) {
                          return CardProduct(
                            product: productsController.products[index],
                          );
                        },
                      ),
          );
        },
      ),
    );
  }
}

class ClientAllCategoryProductsController extends GetxController {
  List<Product> products = [];

  bool isLoading = false;

  Future getProducts(int categoryId) async {
    isLoading = true;
    update();
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/products_category?category_id=$categoryId")
          .timeout(timeOutDuration);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        (json.decode(response.body) as List).map((i) => print(i));
        products = (json.decode(response.body) as List)
            .map((i) => Product.fromJson(i))
            .toList();
        isLoading = false;
        update();
        //return products;
      } else {
        isLoading = false;
        update();
        //return Future.error("");
      }
    } catch (e,t) {
      isLoading = false;
      update();
      print(e);
      print(t);
     // return Future.error(e);
    }
  }
}
