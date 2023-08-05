import 'package:bnaa/controllers/commune_select_controller.dart';
import 'package:bnaa/controllers/stores_controller.dart';
import 'package:bnaa/controllers/stores_filter_controller.dart';
import 'package:bnaa/controllers/wilaya_select_controller.dart';
import 'package:bnaa/models/wilaya.dart';
import 'package:bnaa/views/widgets/cards/cardStore.dart';
import 'package:bnaa/views/widgets/inputs/input_select_wilaya_store_filter.dart';
import 'package:bnaa/views/widgets/inputs/input_select_commune_store_filter.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../widgets/appBar/appBarHome.dart';
import '../../widgets/label/label.dart';

class ClientStoresPage extends StatelessWidget {
  final storesController = Get.put(StoresController());
  final wilayasController = Get.put(WilayaSelectController());
  final storesFilterController = Get.put(StoresFilterController());
  final communeController = Get.put(CommuneSelectController());
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHomeWidget(
        title: 'stores'.tr,
        scaffoldKey: scaffoldKey,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 26.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                            storesFilterController.setWilaya(wilaya: value);
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
                    },
                  ),
                  GetBuilder<CommuneSelectController>(
                    builder: (_) {
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
                          storesFilterController.setCommune(commune: value);
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              ///Filters
              GetBuilder<StoresFilterController>(
                builder: (_) {
                  if (storesFilterController.communes.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      storesController.getStoresWithFilter(
                          wilayaId: storesFilterController
                              .communes.first.wilayaId
                              .toString(),
                          communeList: storesFilterController.communes
                              .map((commune) => commune.id.toString())
                              .toList());
                    });
                    return Wrap(
                      children: storesFilterController.communes
                          .map(
                            (i) => Label(
                              title: Get.deviceLocale?.languageCode == 'fr'
                                  ? i.nameFr! : i.nameAr!,
                              callBack: () {
                                storesFilterController.deleteCommune(
                                    communeId: i.id);
                              },
                            ),
                          )
                          .toList(),
                    );
                  }
                  if (storesFilterController.wilaya != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      storesController.getStoresWithFilter(
                        wilayaId: storesFilterController.wilaya!.id.toString(),
                        communeList: [],
                      );
                    });
                    return Wrap(
                      children: [
                        Label(
                          title:Get.deviceLocale?.languageCode == 'fr'
                              ? storesFilterController.wilaya!.nameFr.toString() : storesFilterController.wilaya!.nameAr.toString(),
                          callBack: () {
                            storesFilterController.initWilaya();
                          },
                        ),
                      ],
                    );
                  }

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    storesController.getStores();
                  });

                  return Container();
                },
              ),
              SizedBox(height: 20.h),

              ///Stores
              GetBuilder<StoresController>(
                builder: (_) {
                  print('rebuild grid');
                  if (!storesController.isLoading) {
                    return DynamicHeightGridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      builder: (ctx, index) {
                        return CardStore(model: storesController.stores[index]);
                      },
                      itemCount: storesController.stores.length,
                      crossAxisCount: 2,
                    );
                  }
                  return Center(child: LoaderStyleWidget());
                },
              ),
              SizedBox(height: 70.h)
            ],
          ),
        ),
      ),
    );
  }
}
