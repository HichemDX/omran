import 'package:bnaa/controllers/store_controllers/store_products_controller.dart';
import 'package:bnaa/models/product.dart';
import 'package:bnaa/views/pages/products/components/productCard2.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductListWidget extends StatefulWidget {
  ProductListWidget({Key? key}) : super(key: key);

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  final productsController = Get.put(StoreProductsController());

  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async {
      List<Product> newProduct =
          await productsController.getProducts(page: pageKey);
      print(newProduct.length);
      if (newProduct.length < 50) {
        _pagingController.appendLastPage(newProduct);
      } else {
        _pagingController.appendPage(newProduct, pageKey + 1);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreProductsController>(
      builder: (_) {
        _pagingController.refresh();
        return PagedListView<int, Product>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Product>(
              noItemsFoundIndicatorBuilder: (context) {
                return Center(
                  child: Text(
                    'no products added'.tr,
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
                return ProductCard2(model: item);
              },
            ));
      },
    );
  }
}
