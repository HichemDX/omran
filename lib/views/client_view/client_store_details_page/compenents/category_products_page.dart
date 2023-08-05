import 'package:bnaa/controllers/client_controllers/store_details_controller.dart';
import 'package:bnaa/models/product.dart';
import 'package:bnaa/views/widgets/cards/cardProduct.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CategoryProductsPage extends StatefulWidget {
  int categoryId;

  CategoryProductsPage({Key? key, required this.categoryId}) : super(key: key);

  @override
  _CategoryProductsPageState createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage>
    with AutomaticKeepAliveClientMixin {
  StoreController storeDetailsController = Get.find();
  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async {
      List<Product> newProduct = widget.categoryId != 0
          ? await storeDetailsController.getProductsByCategory(
              pageKey,
              widget.categoryId,
            )
          : await storeDetailsController.getAllProducts(pageKey);
      if (newProduct.length < 10) {
        _pagingController.appendLastPage(newProduct);
      } else {
        _pagingController.appendPage(newProduct, pageKey + 1);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, Product>(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
        childAspectRatio: 1 / 1.2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      pagingController: _pagingController,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<Product>(
        noItemsFoundIndicatorBuilder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
              child: Text(
                'no products added'.tr,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
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
          return CardProduct(product: item);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
