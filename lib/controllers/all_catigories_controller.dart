import 'dart:convert';

import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/category.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:get/get.dart';

class AllCategoriesController extends GetxController {
  List<Category> categories = [];

  Future<List<Category>> initAllCategoriesController() async {
    if (categories.isEmpty) {
      try {
        Network api = Network();
        var response = await api
            .getWithHeader(apiUrl: "/categories_all")
            .timeout(timeOutDuration);
        print(response.body);
        if (response.statusCode == 200) {
          categories = (json.decode(response.body) as List)
              .map((i) => Category.fromJson(i))
              .toList();

          return categories;
        } else {
          return Future.error("");
        }
      } catch (e,stackTrace) {
        print(e);
        print(stackTrace);
        return Future.error(e);
      }
    }
    return categories;
  }
}
