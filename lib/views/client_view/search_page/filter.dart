import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/all_catigories_controller.dart';
import 'package:bnaa/controllers/commune_select_controller.dart';
import 'package:bnaa/controllers/search_controller.dart';
import 'package:bnaa/controllers/sub_category_select_controller.dart';
import 'package:bnaa/controllers/wilaya_select_controller.dart';
import 'package:bnaa/models/category.dart';
import 'package:bnaa/models/normalButtonWithBorderModel.model.dart';
import 'package:bnaa/models/wilaya.dart';
import 'package:bnaa/views/widgets/inputs/input_select_category_filter.dart';
import 'package:bnaa/views/widgets/inputs/input_select_commune_store_filter.dart';
import 'package:bnaa/views/widgets/inputs/input_select_sub_category_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../models/normalButtonModel.model.dart';
import '../../widgets/buttons/NormalButton.dart';
import '../../widgets/buttons/normalButtonWithBorder.dart';
import '../../widgets/inputs/input_select_wilaya_store_filter.dart';
import '../../widgets/label/label.dart';

class Filter extends StatelessWidget {
  Filter({Key? key}) : super(key: key);

  final wilayasController = Get.put(WilayaSelectController());
  final communeController = Get.put(CommuneSelectController());
  final categoryController = Get.put(AllCategoriesController());
  final subCategoryController = Get.put(SubCategorySelectController());
  final SearchController searchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 487.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 34.w),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(height: 16.h),
            Text('Filtres',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 16.h),
            Container(
              height: 0.5.h,
              decoration: const BoxDecoration(color: AppColors.GREY_TEXT_COLOR),
              width: double.infinity,
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<List<Wilaya>>(
                    future: wilayasController.initWilayaController(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Wilaya>> snapshot) {
                      if (snapshot.hasData) {
                        return InputSelectWilayaStoreFilter(
                          hintText: 'wilaya'.tr,
                          list: snapshot.data!,
                          width: 160.w,
                          onSelected: (value) {
                            searchController.setWilaya(value);
                            communeController.getCommunes(value.id);
                          },
                        );
                      }
                      return InputSelectWilayaStoreFilter(
                        hintText: 'wilaya'.tr,
                        list: [],
                        isLoading: true,
                        width: 160.w,
                      );
                    }),
                GetBuilder<CommuneSelectController>(builder: (_) {
                  print("rebuild commune");
                  if (communeController.isLoading) {
                    return InputSelectCommuneStoreFilter(
                      hintText: 'commune'.tr,
                      list: [],
                      isLoading: true,
                      width: 160.w,
                    );
                  }
                  return InputSelectCommuneStoreFilter(
                    hintText: 'commune'.tr,
                    list: communeController.selectedCommunes,
                    width: 160.w,
                    onChange: (value) {
                      searchController.addCommune(value);
                    },
                  );
                }),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            GetBuilder<SearchController>(builder: (_) {
              return Column(
                children: [
                  searchController.selectedWilaya != null
                      ? Label(
                          title: Get.deviceLocale?.languageCode == 'fr'
                              ? '${searchController.selectedWilaya!.nameFr}'
                              : '${searchController.selectedWilaya!.nameAr}',
                          callBack: () {
                            searchController.initWilaya();
                          })
                      : Container(),
                  Wrap(
                    children: searchController.selectedCommunes
                        .map((i) => Label(
                              title: Get.deviceLocale?.languageCode == 'fr'
                                  ? i.nameFr!
                                  : i.nameAr!,
                              callBack: () {
                                searchController.removeCommune(i.id);
                              },
                            ))
                        .toList(),
                  ),
                ],
              );
            }),
            SizedBox(height: 16.h),
            Container(
              height: 0.5.h,
              decoration: const BoxDecoration(color: AppColors.GREY_TEXT_COLOR),
              width: double.infinity,
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              FutureBuilder<List<Category>>(
                  future: categoryController.initAllCategoriesController(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Category>> snapshot) {
                    if (snapshot.hasData) {
                      return InputSelectCategoryFilter(
                        hintText: "category".tr,
                        list: snapshot.data!,
                        width: 160.w,
                        onChange: (value) {
                          subCategoryController.getSubCategories(value.id);
                          searchController.setCategory(value);
                        },
                      );
                    }
                    return InputSelectCategoryFilter(
                      hintText: "category".tr,
                      list: [],
                      isLoading: true,
                      width: 160.w,
                      onChange: (value) {
                        subCategoryController.getSubCategories(value.id);
                      },
                    );
                  }),
              GetBuilder<SubCategorySelectController>(builder: (_) {
                if (subCategoryController.isLoading) {
                  return InputSelectSubCategoryFilter(
                    hintText: "Sous category".tr,
                    list: [],
                    isLoading: true,
                    width: 160.w,
                    onChange: (value) {
                      searchController.addSubCategory(value);
                    },
                  );
                }
                return InputSelectSubCategoryFilter(
                  hintText: "Sous category".tr,
                  list: subCategoryController.selectedCategories,
                  width: 160.w,
                  onChange: (value) {
                    searchController.addSubCategory(value);
                  },
                );
              }),
            ]),
            SizedBox(
              height: 10.h,
            ),
            GetBuilder<SearchController>(builder: (_) {
              return Column(
                children: [
                  searchController.selectedCategory != null
                      ? Label(
                          title: Get.deviceLocale?.languageCode == 'fr'
                              ? '${searchController.selectedCategory!.nameFr}'
                              : '${searchController.selectedCategory!.nameAr}',
                          callBack: () {
                            searchController.initCategory();
                          })
                      : Container(),
                  Wrap(
                    children: searchController.selectedSubCategory
                        .map((i) => Label(
                              title: Get.deviceLocale?.languageCode == 'fr'
                                  ? i.nameFr!
                                  : i.nameAr!,
                              callBack: () {
                                searchController.removeSubCategory(i.id);
                              },
                            ))
                        .toList(),
                  ),
                ],
              );
            }),
            SizedBox(height: 16.h),
            Container(
              height: 0.5.h,
              decoration: const BoxDecoration(color: AppColors.GREY_TEXT_COLOR),
              width: double.infinity,
            ),
            SizedBox(
              height: 20.h,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text('price'.tr,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.BLUE_COLOR,
                  )),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: searchController.minPrice,
                  style: TextStyle(fontSize: 14.sp),
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'min prix',
                  ),
                )),
                SizedBox(
                  width: 40.w,
                ),
                Expanded(
                    child: TextFormField(
                  controller: searchController.maxPrice,
                  style: TextStyle(fontSize: 14.sp),
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'max prix',
                  ),
                ))
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              children: [
                NormalButtonWithBorder(
                  model: NormalButtonWithBorderModel(
                    textFontSize: 16.sp,
                    colorText: AppColors.BLUE_COLOR,
                    bColor: AppColors.BLUE_COLOR,
                    colorButton: Colors.white,
                    width: 150.w,
                    wBorder: 1.sp,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    height: 42.h,
                    radius: 10.r,
                    text: 'cancel'.tr,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                NormalButton(
                  model: NormalButtomModel(
                      textFontSize: 16.sp,
                      colorText: Colors.white,
                      colorButton: AppColors.BLUE_COLOR,
                      width: 150.w,
                      onTap: () {
                        searchController.getResult();
                        Navigator.pop(context);
                      },
                      height: 42.h,
                      radius: 10.r,
                      text: 'Chercher'),
                ),
              ],
            )
          ]),
        ),
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
    );
  }
}
