import 'dart:io';

import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/all_catigories_controller.dart';
import 'package:bnaa/controllers/store_controllers/store_products_controller.dart';
import 'package:bnaa/models/category.dart';
import 'package:bnaa/models/product.dart';
import 'package:bnaa/services/image_picker_service.dart';
import 'package:bnaa/views/store_view/store_add_product/components/category_selecte_widget.dart';
import 'package:bnaa/views/store_view/store_add_product/components/image_file_carousel.dart';
import 'package:bnaa/views/widgets/appBar/appBarHome.dart';
import 'package:bnaa/views/widgets/inputs/input_select_wilaya_store_filter.dart';
import 'package:bnaa/views/widgets/inputs/inputTextField.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class StoreEditProduct extends StatefulWidget {
  Product product;

  StoreEditProduct({required this.product});

  @override
  State<StoreEditProduct> createState() => _StoreEditProductState();
}

class _StoreEditProductState extends State<StoreEditProduct> {
  String? title;
  String? description;
  String? unit;
  String? price;
  String? qnt;
  List<File> imageFiles = [];

  final categoriesController = Get.put(AllCategoriesController());
  final scaffoldKey = GlobalKey<ScaffoldState>();

  _pickImage() async {
    imageFiles = await ImagePickerService.getImagesFromGallery();
    setState(() {});
  }

  StoreProductsController storeProductsController = Get.find();
  late String categoryId;

  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  _updateProduct() async {
    if (formKey.currentState!.validate()) {
      Loader.show(context, progressIndicator: LoaderStyleWidget());
      Map<String, String> data = {
        "title": title!,
        "product_id": widget.product.id!.toString(),
        "description": description!,
        "price": price!.toString(),
        "category": "1",
        "unit": "1",
      };
      print(data);
      await storeProductsController.updateProduct(
          data: data, filesPath: imageFiles);
      Loader.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Container(
        height: 50.h,
        child: InkWell(
          onTap: _updateProduct,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('edit'.tr,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(
              width: 12.w,
            ),
            SvgPicture.asset(
              'assets/icons/edit.svg',
              height: 20.sp,
              width: 20.sp,
              color: Colors.white,
            )
          ]),
        ),
        decoration: const BoxDecoration(color: AppColors.BLUE_COLOR),
      ),
      appBar: appBarHomeWidget(
        scaffoldKey: scaffoldKey,
        title: 'edit'.tr,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            color: Colors.grey.shade100,
            height: 330.h,
            width: double.infinity,
            child: Stack(
              children: [
                imageFiles.isNotEmpty
                    ? ImageFilesCarousel(listImages: imageFiles)
                    : Center(
                        child: SvgPicture.asset(
                            'assets/icons/imageCarouselIcon.svg')),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.add_photo_alternate_outlined,
                      color: AppColors.BLUE_COLOR,
                      size: 30,
                    ),
                    onPressed: _pickImage,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 14.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'product name'.tr,
                    style: TextStyle(
                      color: AppColors.BLUE_COLOR,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                  InputTextField(
                    hintText: "Titre".tr,
                    initValue: widget.product.name,
                    valueStater: (value) {
                      title = value;
                    },
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'description'.tr,
                    style: TextStyle(
                      color: AppColors.BLUE_COLOR,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                  InputTextField(
                    hintText: "Description".tr,
                    initValue: widget.product.desc,
                    valueStater: (value) {
                      description = value;
                    },
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('unit of measure'.tr,
                              style: TextStyle(
                                  color: AppColors.BLUE_COLOR,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp)),
                          InputSelectWilayaStoreFilter(
                              hintText: "", list: [], width: 170.w)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('category'.tr,
                              style: TextStyle(
                                  color: AppColors.BLUE_COLOR,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp)),
                          FutureBuilder<List<Category>>(
                              future: categoriesController
                                  .initAllCategoriesController(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<Category>> snapshot) {
                                if (snapshot.hasData) {
                                  return CategorySelectWidget(
                                    hintText: 'categories'.tr,
                                    onChange: (value) {},
                                    list: categoriesController.categories,
                                    width: 160.w,
                                  );
                                } else {
                                  return CategorySelectWidget(
                                    hintText: 'categories'.tr,
                                    onChange: (value) {},
                                    list: categoriesController.categories,
                                    width: 100,
                                    isLoading: true,
                                  );
                                }
                              })
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text('unit price'.tr,
                      style: TextStyle(
                          color: AppColors.BLUE_COLOR,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp)),
                  InputTextField(
                    hintText: "price".tr,
                    initValue: '${widget.product.price}',
                    valueStater: (value) {
                      price = value;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text('minimum quantity'.tr,
                      style: TextStyle(
                          color: AppColors.BLUE_COLOR,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp)),
                  InputTextField(hintText: "1/2"),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
