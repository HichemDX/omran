import 'dart:convert';

import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/sub_category.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:get/get.dart';

class SubCategorySelectController extends GetxController {

  Map<String, List<SubCategory>> subCategoryMap = {};
  List<SubCategory> selectedCategories = [];
  bool isLoading = false;

  Future<List<SubCategory>> getSubCategories(categoryId) async {
    selectedCategories.clear();
    isLoading = true;
    update();
    if (subCategoryMap[categoryId.toString()] == null) {
      try {
        Network api = Network();
        var response = await api
            .getWithHeader(apiUrl: "/soucategory/?category_id=$categoryId")
            .timeout(timeOutDuration);
        if (response.statusCode == 200) {
          subCategoryMap[categoryId.toString()] =
              (json.decode(response.body) as List)
                  .map((i) => SubCategory.fromJson(i))
                  .toList();
          selectedCategories.addAll(subCategoryMap[categoryId.toString()]!);
          isLoading = false;
          update();
          return subCategoryMap[categoryId.toString()]!;
        } else {
          isLoading = false;
          update();

          return Future.error("");
        }
      } catch (e) {
        isLoading = false;
        update();

        print(e);
        return Future.error(e);
      }
    }
    selectedCategories.addAll(subCategoryMap[categoryId.toString()]!);
    isLoading = false;
    update();
    return subCategoryMap[categoryId.toString()]!;
  }
}
