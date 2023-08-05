import 'dart:developer';

import 'package:bnaa/base/custom_SmartRefresher.dart';
import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/store_controllers/current_store_controller.dart';
import 'package:bnaa/controllers/store_controllers/store_products_controller.dart';
import 'package:bnaa/models/category.dart';
import 'package:bnaa/models/product.dart';
import 'package:bnaa/models/store.dart';
import 'package:bnaa/views/pages/products/components/productCard2.dart';
import 'package:bnaa/views/store_view/store_add_product/store_add_product.dart';
import 'package:bnaa/views/store_view/store_edit_profile/store_edit_profile.dart';
import 'package:bnaa/views/store_view/store_profile_screen/widgets/categories_paging_widget.dart';
import 'package:bnaa/views/widgets/appBar/appBarHome.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StoreProfileScreen extends StatefulWidget {
  @override
  State<StoreProfileScreen> createState() => _StoreProfileScreenState();
}

class _StoreProfileScreenState extends State<StoreProfileScreen> {
  final storeDetailsController = Get.put(CurrentStoreController());
  final scrollController = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productController = Get.put(StoreProductsController());
  List<Category> listCategories = [];
  List<Product> listProduct = [];
  Store? store;
  bool loading = true;
  int idCategory = 0;
  int _pageSize = 10;
  int pageNo = 1;
  RefreshController refreshController = RefreshController(initialRefresh: true);

  getAllCategory() async {
    List<Category> result = await productController
        .getStoreCategories(storeDetailsController.store!.id);

    listCategories = result;
  }

  getStoreDetails() async {
    Store result = await storeDetailsController.getStoreDetails();
    store = result;
  }

  bool loading2 = false;

  Future getDetails(int pageKey) async {
    pageNo = pageKey;
    if (pageKey == 1) {
      setState(() {
        loading = true;
        listProduct = [];
      });
      await getStoreDetails();
      await getAllCategory();
    }

    List<Product>? result = idCategory != 0
        ? await productController.getProductsByCategory(
            pageKey, idCategory, store!.id)
        : await productController.getProducts(page: pageKey);
    log("${List.generate(result.length, (index) => result[index].toJson())}");

    if (result.isEmpty) {
      setState(() {
        loading = false;
        listProduct = [];
        refreshController.refreshCompleted();
      });
      return;
    } else {
      final isLastPage = result.length < _pageSize;

      if (isLastPage) {
        listProduct = listProduct + result;
        listProduct = listProduct.toSet().toList();
        refreshController.refreshCompleted();
        refreshController.loadComplete();
        refreshController.loadNoData();
      } else if (result.isNotEmpty) {
        listProduct = listProduct + result;
        listProduct = listProduct.toSet().toList();
        refreshController.refreshCompleted();
        refreshController.loadComplete();
      }
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarHomeWidget(title: 'stores'.tr, scaffoldKey: scaffoldKey),
      body: SizedBox(
        height: double.infinity,
        child: CustomSmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onLoading: () {
            getDetails(pageNo + 1);
          },
          onRefresh: () {
            getDetails(1);
          },
          child: storeDetailsController.store == null || store == null
              ? Center(child: LoaderStyleWidget())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Card(
                          elevation: 2,
                          child: Container(
                            padding: EdgeInsets.all(20.sp),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {
                                      Get.to(
                                        () => StoreEditProfile(
                                          store: storeDetailsController.store!,
                                        ),
                                      );
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/edit.svg',
                                      width: 20,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    const SizedBox(height: 50),
                                    SizedBox(
                                      height: 120.sp,
                                      width: 120.sp,
                                      child: 
                                        storeDetailsController.store!.image! ==
                                  'https://omran-dz.com/icons/store.png'
                              ? Image.asset(
                                  'assets/icons/profilestore3.png',
                                  fit: BoxFit.cover,
                                  height: 100.sp,
                                  width: 100.sp,
                                )
                                      
                                      :CachedNetworkImage(
                                        imageUrl: storeDetailsController
                                            .store!.image
                                            .toString(),
                                        height: 200.sp,
                                        width: 200.sp,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Container(
                                      width: 150.w,
                                      height: 1.h,
                                      color: AppColors.INACTIVE_GREY_COLOR,
                                    ),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/phoneIcon.svg',
                                          height: 20,
                                          width: 20,
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          store!.phone!,
                                          style: TextStyle(fontSize: 14.sp),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/locationIcon.svg',
                                          height: 20,
                                          width: 20,
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          Get.locale?.languageCode == 'fr'
                                              ? '${store!.wilaya!.nameFr.toString()},${store!.commune!.nameFr.toString()}'
                                              : '${store!.wilaya!.nameAr.toString()},${store!.commune!.nameAr.toString()}',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/locationIcon.svg',
                                          height: 15.sp,
                                          width: 15.sp,
                                          color: Colors.transparent,
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          store!.addres!,
                                          style: TextStyle(fontSize: 14.sp),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 14.h),
                      CategoriesPagingWidget(
                          id: idCategory,
                          listCategories: listCategories,
                          onChange: (val) {
                            idCategory = val;
                            getDetails(1);
                          }),
                      SizedBox(height: 14.h),
                      if (loading) Center(child: LoaderStyleWidget()),
                      if (listProduct.isEmpty && !loading)
                        Center(
                          child: Text(
                            'no products added'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ...List.generate(
                        listProduct.length,
                        (index) {
                          return ProductCard2(
                            model: listProduct[index],
                            onRefresh: () {
                              getDetails(1);
                            },
                          );
                        },
                      ),
                      SizedBox(height: 18.54.h),
                    ],
                  ),
                ),
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () async {
          await Get.to(() => StoreAddProduct());
          await getDetails(1);
        },
        icon: const Icon(
          Icons.add_circle_rounded,
          color: AppColors.BLUE_COLOR,
          size: 50,
        ),
      ),
    );
  }
}
