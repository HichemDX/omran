import 'package:bnaa/controllers/client_controllers/profile_controller.dart';
import 'package:bnaa/controllers/search_controller.dart';
import 'package:bnaa/views/client_view/search_page/components/search_input_widget.dart';
import 'package:bnaa/views/widgets/cards/cardProduct.dart';
import 'package:bnaa/views/widgets/label/label.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../models/product.dart';
import '../../widgets/appBar/appBar.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = Get.put(SearchController());
  final profilController = Get.put(ProfileController());

  final scrollController = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        searchController.loadMoreResult();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int sortByWilaya(Product a, Product b, String wilayaName) {
      bool isWilayaA = a.address!.split(',')[0].toLowerCase().trim() == wilayaName;
      bool isWilayaB = b.address!.split(',')[0].toLowerCase().trim() == wilayaName;

      if (isWilayaA && !isWilayaB) {
        return -1; // a comes before b
      } else if (!isWilayaA && isWilayaB) {
        return 1; // b comes before a
      } else {
        return 0; // no change in order
      }
    }
    return Scaffold(
      appBar: AppBarWidget(
        title: 'search'.tr,
        icon: 'assets/icons/return.svg',
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<ProfileController>(builder: (context) {
              return GetBuilder<SearchController>(
                builder: (_) {
                  List<Widget> labels = [];
                  for (var element in searchController.selectedCommunes) {
                    labels.add(
                      Label(
                        title: Get.deviceLocale?.languageCode == 'fr'
                            ? element.nameFr!
                            : element.nameAr.toString(),
                        callBack: () {
                          searchController.removeCommune(element.id);
                        },
                      ),
                    );
                  }
                  for (var element in searchController.selectedSubCategory) {
                    labels.add(
                      Label(
                        title: Get.deviceLocale?.languageCode == 'fr'
                            ? element.nameFr!
                            : element.nameAr!,
                        callBack: () {
                          searchController.removeSubCategory(element.id);
                        },
                      ),
                    );
                  }
                  if (searchController.minPrice.value.text.isNotEmpty) {
                    labels.add(
                      Label(
                        title: 'Min :${searchController.minPrice.value.text}',
                        callBack: () {},
                      ),
                    );
                  }
                  if (searchController.maxPrice.value.text.isNotEmpty) {
                    labels.add(Label(
                        title: 'Max :${searchController.maxPrice.value.text}',
                        callBack: () {}));
                  }
                  if (searchController.isLoading != true &&
                      searchController.result.isNotEmpty) {
                    for (var element in searchController.result) {
                      print('hichem123 : ${element.address}');
                      print('hichem1 : ${profilController.user!.wilaya!.nameFr!}');
                    }
                    searchController.result
                        .map((e) => print('hichem123 : ${e.address}'));
                  }

                  return Column(
                    children: [
                      const SearchInputWidget(),
                      Wrap(children: labels),
                      Expanded(
                        child: searchController.isLoading
                            ? Center(child: LoaderStyleWidget())
                            : searchController.result.isEmpty
                                ? Center(
                                    child: Text(
                                      'no result found'.tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : DynamicHeightGridView(
                                    controller: scrollController,
                                    itemCount: searchController.result.length,
                                    builder: (BuildContext context, int index) {
                                      searchController.result.sort((a, b) =>
                                          sortByWilaya(
                                              a,
                                              b,
                                              profilController
                                                  .user!.wilaya!.nameFr!.toLowerCase().trim()));
                                                    for (var element
                                          in searchController.result) {
                                        print('after : ${element.address}');
                                        print(
                                            'after : ${profilController.user!.wilaya!.nameFr!}');
                                      }
                                      return Container(
                                        height: 260,
                                        child: profilController
                                                    .user!.wilaya!.nameFr!
                                                    .toLowerCase().trim() ==
                                                searchController
                                                    .result[index].address!
                                                    .split(",")[0]
                                                    .toLowerCase().trim()
                                            ? CardProduct(
                                                favorite: true,
                                                product: searchController
                                                    .result[index],
                                              )
                                            : CardProduct(
                                                product: searchController
                                                    .result[index],
                                              ),
                                      );
                                    },
                                    crossAxisCount: 2,
                                  ),
                      ),
                    ],
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
