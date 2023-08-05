import 'dart:convert';

import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/category.dart';
import 'package:bnaa/models/product.dart';
import 'package:bnaa/models/store.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:bnaa/services/server_response.dart';
import 'package:bnaa/services/toast_service.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  Store? store;
  bool isLoading = false;
  int? categoryId;
  List<Product> products = [];
  List<Category> categories = [];

  Future<Store> getStoreDetails(storeId) async {
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/client_store_details_page?id=$storeId")
          .timeout(timeOutDuration);
      print(response.body);
      if (response.statusCode == 200) {
        store = Store.fromJson(
            json.decode(response.body)['client_store_details_page']);

        return store!;
      } else {
        return Future.error("");
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<bool> sendReport({
    required int storId,
    required String reportType,
    required String content,
  }) async {
    var api = Network();

    /*SharedPreferences storage = await SharedPreferences.getInstance();
    final String? fcm = storage.getString('device_id');*/

    try {
      final response = await api.post(
        '/report',
        {
          "store_id": storId,
          "report_type": reportType,
          "content": content,
        },
      );

      if (response.statusCode == 200) {
        ToastService.showSuccessToast("envoyé avec succès".tr);
        return true;
      } else {
        ServerResponse.serverResponseHandler(response: response);
        return false;
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      ServerResponse.checkNetworkError();
      return false;
    }
  }

  Future<List<Category>> getStoreCategories() async {
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/categories_by_store/${store!.id}")
          .timeout(timeOutDuration);
      print(response.body);
      if (response.statusCode == 200) {
        categories = (json.decode(response.body) as List)
            .map((i) => Category.fromJson(i))
            .toList();
        print(categories.length);
        return categories;
      } else {
        return Future.error("");
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<List<Product>> getProductsByCategory(page, categoryId) async {
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(
              apiUrl:
                  "/products_stor/?stor_id=${store!.id}&category_id=$categoryId&page=$page")
          .timeout(timeOutDuration);
      print(response.body);
      if (response.statusCode == 200) {
        // define pagination params

        products = (json.decode(response.body) as List)
            .map((i) => Product.fromJson(i))
            .toList();

        return products;
      } else {
        return Future.error("");
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<List<Product>> getAllProducts(page) async {
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(
              apiUrl: "/products_stor?page=$page&stor_id=${store!.id}")
          .timeout(timeOutDuration);
      print(response.body);
      if (response.statusCode == 200) {
        // define pagination params
        products = (json.decode(response.body) as List)
            .map((i) => Product.fromJson(i))
            .toList();
        return products;
      } else {
        return Future.error("");
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  selectStore(store) {
    this.store = store;
  }
}
