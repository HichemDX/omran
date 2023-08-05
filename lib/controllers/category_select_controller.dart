import 'dart:convert';

import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/category.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:get/get.dart';

class CategorySelectController extends GetxController {
  List<Category> categories = [];

  Future<List<Category>> initCategoryController() async {
    if (categories.isEmpty) {
      try {
        Network api = Network();
        var response =
            await api.getWithHeader(apiUrl: "/wilaya").timeout(timeOutDuration);
        if (response.statusCode == 200) {
          categories = (json.decode(response.body) as List)
              .map((i) => Category.fromJson(i))
              .toList();

          return categories;
        } else {
          return Future.error("");
        }
      } catch (e) {
        print(e);
        return Future.error(e);
      }
    }
    return categories;
  }
}
