import 'package:bnaa/controllers/client_controllers/store_details_controller.dart';
import 'package:bnaa/models/category.dart';
import 'package:bnaa/views/client_view/client_store_details_page/compenents/categories_list_widget.dart';
import 'package:bnaa/views/client_view/client_store_details_page/compenents/category_products_page.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesPagingWidget extends StatefulWidget {
  const CategoriesPagingWidget({Key? key}) : super(key: key);

  @override
  _CategoriesPagingWidgetState createState() => _CategoriesPagingWidgetState();
}

class _CategoriesPagingWidgetState extends State<CategoriesPagingWidget> {
  StoreController storeDetailsController = Get.find();
  int index = 0;
  List<Widget> categoryPage = [
    CategoryProductsPage(key: const Key('0'), categoryId: 0)
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: storeDetailsController.getStoreCategories(),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          for (var element in storeDetailsController.categories) {
            categoryPage.add(
              CategoryProductsPage(
                key: Key(element.id!.toString()),
                categoryId: element.id!,
              ),
            );
          }
          return StatefulBuilder(
            builder: (context, StateSetter setStatee) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CategoriesListWidget(
                      activeId: index,
                      categories: storeDetailsController.categories,
                      onChange: (page) {
                        setStatee(() {
                          print(page);
                          index = page;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  categoryPage[index],
                ],
              );
            },
          );
        }
        return Center(child: LoaderStyleWidget());
      },
    );
  }
}
