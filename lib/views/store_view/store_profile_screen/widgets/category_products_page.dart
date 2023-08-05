import 'package:bnaa/controllers/store_controllers/current_store_controller.dart';
import 'package:bnaa/controllers/store_controllers/store_products_controller.dart';
import 'package:bnaa/models/product.dart';
import 'package:bnaa/views/pages/products/components/productCard2.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CategoryProductsPage extends StatefulWidget {
  int categoryId;
  CategoryProductsPage({Key? key,required this.categoryId}) : super(key: key);

  @override
  _CategoryProductsPageState createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> with AutomaticKeepAliveClientMixin{
  StoreProductsController productController = Get.find();
  CurrentStoreController storeDetailsController = Get.find();
  final PagingController<int, Product> _pagingController =
  PagingController(firstPageKey: 1);
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async {

      List<Product> newProduct = widget.categoryId != 0? await productController.getProductsByCategory(pageKey,widget.categoryId,storeDetailsController.store!.id) :await productController.getProducts(page: pageKey);
      if(newProduct.length < 10){
        _pagingController.appendLastPage(newProduct);
      }else {
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
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            builderDelegate: PagedChildBuilderDelegate<Product>(
                noItemsFoundIndicatorBuilder: (context){
                  return Center(
                    child: Text('no products added'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: Colors.black,
                        )),
                  );
                },
                firstPageProgressIndicatorBuilder: (context){
                  return Center(child: LoaderStyleWidget(),);
                },
                newPageProgressIndicatorBuilder: (context){
                  return Center(child: LoaderStyleWidget());
                },
                itemBuilder: (context, item, index) {
                 return ProductCard2(
                      model: item);
                }));
      }
    );
  }

  @override
  bool get wantKeepAlive => true;
}
