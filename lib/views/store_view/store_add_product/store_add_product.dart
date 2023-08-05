import 'dart:developer';
import 'dart:io';

import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/all_catigories_controller.dart';
import 'package:bnaa/controllers/store_controllers/current_store_controller.dart';
import 'package:bnaa/controllers/store_controllers/store_products_controller.dart';
import 'package:bnaa/controllers/units_controller.dart';
import 'package:bnaa/models/category.dart';
import 'package:bnaa/models/image.dart';
import 'package:bnaa/models/product.dart';
import 'package:bnaa/models/unit.dart';
import 'package:bnaa/services/image_picker_service.dart';
import 'package:bnaa/utils/ui_helper.dart';
import 'package:bnaa/views/store_view/store_add_product/components/category_selecte_widget.dart';
import 'package:bnaa/views/store_view/store_add_product/components/image_file_carousel.dart';
import 'package:bnaa/views/store_view/store_add_product/components/unit_select_widget.dart';
import 'package:bnaa/views/widgets/inputs/inputTextField.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


class StoreAddProduct extends StatefulWidget {
  Product? product;

  StoreAddProduct({this.product});

  @override
  State<StoreAddProduct> createState() => _StoreAddProductState();
}

class _StoreAddProductState extends State<StoreAddProduct> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final StoreProductsController storeProductsController =
      Get.put(StoreProductsController());
  final categoriesController = Get.put(AllCategoriesController());
  final unitsController = Get.put(UnitsController());

  //final storeProductsController = Get.put(StoreProductsController());

  String? title;
  String? address;

  String? description;
  String? unitId;
  String? categoryId;
  int? price;
  num? qnt;
  num? min_qnt;
  List imageFiles = [];

  _updateProduct() async {
    if (formKey.currentState!.validate()) {
      Loader.show(context, progressIndicator: LoaderStyleWidget());
      Map<String, String> data = {
        "product_id": widget.product!.id!.toString(),
        "title": title!,
        "description": description!,
        "price": price!.toString(),
        "category": categoryId!,
        "unit": unitId!,
        "min_qty": min_qnt.toString(),
        "qty": qnt.toString(),
      };
      List<File> files = [];
      for (var element in imageFiles) {
        if (element is File) {
          files.add(element);
        }
      }
      bool res = await storeProductsController.updateProduct(
          data: data, filesPath: files);
      Loader.hide();
      if (res) {
        //Get.back();

        Fluttertoast.showToast(msg: "Modified Successfully".tr);
      } else {
        Fluttertoast.showToast(msg: "Erreur s'est produite".tr);
      }
    }
  }

  _addProduct() async {
    if (formKey.currentState!.validate()) {
      Loader.show(context, progressIndicator: LoaderStyleWidget());
      Map<String, String> data = {
        "title": title!,
        "description": description!,
        "price": price!.toString(),
        "category": categoryId!,
        "unit": unitId!,
        "min_qty": min_qnt.toString(),
        "qty": qnt.toString(),
      };

      try {
        List<File> files = [];
        for (var element in imageFiles) {
          if (element is File) {
            files.add(element);
          }
        }
        final res = await storeProductsController.addProduct(
            data: data, filesPath: files);
        Loader.hide();
        if (res) {
          CurrentStoreController storeController = Get.find();
          storeController.update();
          Fluttertoast.showToast(msg: "Added Successfully".tr);
        }
        //Get.back();
      } catch (error) {
        Loader.hide();
        Fluttertoast.showToast(msg: "Erreur s'est produite".tr);
      }
    }
  }

  _deleteProduct() {
    Loader.show(context, progressIndicator: LoaderStyleWidget());
    storeProductsController
        .deleteProduct(productId: widget.product!.id)
        .then((value) {
      Loader.hide();
      if (value) {
        Get.back();
        Fluttertoast.showToast(msg: "Deleted Successfully");
      }
    });
  }

  _deleteImage(int index) async {
    Loader.show(context, progressIndicator: LoaderStyleWidget());
    bool value = await storeProductsController.deleteImageProduct(
        imageId: (imageFiles[index] as ProductImage).id);
    log("value : $value");
    if (value) {
      setState(() {
        imageFiles.removeAt(index);
      });
    }
    Loader.hide();
  }

  _pickImage() async {
    List<File> files = await ImagePickerService.getImagesFromGallery();
    imageFiles.addAll(files);
    setState(() {});
  }

  @override
  void initState() {
    title = widget.product != null ? widget.product!.name : "";
    address = widget.product != null ? widget.product!.address : "";
    description = widget.product != null ? widget.product!.desc : "";
    unitId = widget.product != null ? "${widget.product!.unitId}" : "";
    categoryId = widget.product != null ? "${widget.product!.categoryId}" : "";
    price = widget.product != null ? int.tryParse(widget.product!.price!) : 0;
    qnt = widget.product != null ? widget.product!.qty : 1;
    min_qnt = widget.product != null ? widget.product!.quanititeMinimum : 1;
    if (widget.product != null) imageFiles.addAll(widget.product!.images ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.BLUE_COLOR,
        leadingWidth: 30,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          widget.product != null ? 'edit'.tr : 'add'.tr,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          if (widget.product != null)
            IconButton(
              onPressed: () {
                _deleteProduct();
              },
              icon: const Icon(Icons.delete),
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                color: Colors.grey.shade100,
                height: 330.h,
                width: double.infinity,
                child: Stack(
                  children: [
                    imageFiles.isNotEmpty
                        ? ImageFilesCarousel(
                            listImages: imageFiles,
                            deletedImage: (index) {
                              if (imageFiles[index] is File) {
                                setState(() {
                                  imageFiles.removeAt(index);
                                });
                              } else {
                                _deleteImage(index);
                              }
                            },
                          )
                        : Center(
                            child: SvgPicture.asset(
                              'assets/icons/imageCarouselIcon.svg',
                            ),
                          ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          icon: const Icon(
                            Icons.add_photo_alternate_outlined,
                            color: AppColors.BLUE_COLOR,
                            size: 30,
                          ),
                          onPressed: _pickImage),
                    )
                  ],
                ),
              ),
              SizedBox(height: 14.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                      hintText: 'product name'.tr,
                      initValue:
                          widget.product != null && widget.product!.name != null
                              ? widget.product!.name
                              : null,
                      valueStater: (value) {
                        title = value;
                      },
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'unit of measure'.tr,
                              style: TextStyle(
                                color: AppColors.BLUE_COLOR,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                            FutureBuilder<List<Unit>>(
                              future: unitsController.getUnits(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<Unit>> snapshot) {
                                if (snapshot.hasData) {
                                  return UnitSelectWidget(
                                    initialValue: widget.product != null
                                        ? widget.product!.unitId
                                        : null,
                                    hintText: 'unit of measure'.tr,
                                    onChange: (value) {
                                      unitId = value.id.toString();
                                    },
                                    list: unitsController.units,
                                    width: 160.w,
                                  );
                                } else {
                                  return UnitSelectWidget(
                                    hintText: 'unit of measure'.tr,
                                    onChange: (value) {
                                      unitId = value.id.toString();
                                    },
                                    list: unitsController.units,
                                    width: 100,
                                    isLoading: true,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'category'.tr,
                              style: TextStyle(
                                color: AppColors.BLUE_COLOR,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                            FutureBuilder<List<Category>>(
                              future: categoriesController
                                  .initAllCategoriesController(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<Category>> snapshot) {
                                if (snapshot.hasData) {
                                  return CategorySelectWidget(
                                    initialValue: widget.product != null
                                        ? widget.product!.categoryId
                                        : null,
                                    hintText: 'categories'.tr,
                                    onChange: (value) {
                                      categoryId = value.id.toString();
                                    },
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
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'unit price'.tr,
                      style: TextStyle(
                        color: AppColors.BLUE_COLOR,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                    InputTextField(
                      hintText: 'unit price'.tr,
                      initValue: widget.product != null &&
                              widget.product!.price != null
                          ? widget.product!.price
                          : null,
                      keyboardType: TextInputType.number,
                      valueStater: (value) {
                        price = int.parse(value);
                      },
                    ),
                    SizedBox(height: 20.h),
                    /*
                    Text(
                      'Quantity'.tr,
                      style: TextStyle(
                        color: AppColors.BLUE_COLOR,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                    InputTextField(
                      hintText: 'Quantity'.tr,
                      initValue:
                          widget.product != null && widget.product!.qty != null
                              ? getQty(qty: widget.product!.qty!.toString())
                              : null,
                      keyboardType: TextInputType.number,
                      valueStater: (value) {
                        qnt = double.parse(value);
                      },
                    ),
                    SizedBox(height: 20.h),
                    */
                    Text(
                      'minimum quantity'.tr,
                      style: TextStyle(
                        color: AppColors.BLUE_COLOR,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                    InputTextField(
                      hintText: 'minimum quantity'.tr,
                      initValue: widget.product != null &&
                              widget.product!.quanititeMinimum != null
                          ? getQty(
                              qty: widget.product!.quanititeMinimum!.toString())
                          : null,
                      keyboardType: TextInputType.number,
                      valueStater: (value) {
                        min_qnt = double.parse(value);
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
                      hintText: 'description'.tr,
                      initValue:
                          widget.product != null && widget.product!.desc != null
                              ? widget.product!.desc!.toString()
                              : null,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      valueStater: (value) {
                        description = value;
                      },
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.h,
        child: InkWell(
          onTap: () {
            if (widget.product != null) {
              _updateProduct();
              return;
            }
            _addProduct();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.product != null ? 'edit'.tr : 'add'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 12.w),
              SvgPicture.asset(
                'assets/icons/garage.svg',
                height: 20.sp,
                width: 20.sp,
                color: Colors.white,
              ),
            ],
          ),
        ),
        decoration: const BoxDecoration(color: AppColors.BLUE_COLOR),
      ),
    );
  }
}
