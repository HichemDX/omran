import 'dart:convert';

import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/product.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:get/get.dart';

class FavoriteProductController extends GetxController {
  List<Product> favoriteProducts = [];

  bool isLoading = false;

  Future<List<Product>> getFavoriteProducts() async {
    isLoading = true;
    update();
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/favorites")
          .timeout(timeOutDuration);
      print(response.body);
      if (response.statusCode == 200) {
        favoriteProducts = (json.decode(response.body) as List)
            .map((i) => Product.fromJson(i)..save = true)
            .toList();
        isLoading = false;
        update();
        return favoriteProducts.toSet().toList();
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

  Future<bool> addToFavorite(product) async {
    try {
      var data = {"product_id": product.id};
      Network api = Network();
      var response = await api
          .postWithHeader(apiUrl: "/set_favorite", data: data)
          .timeout(timeOutDuration);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        favoriteProducts.add(product);
        update();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> removeFromFavorite(product) async {
    try {
      var data = {"product_id": product.id};
      Network api = Network();
      var response = await api
          .postWithHeader(apiUrl: "/remove_favorite", data: data)
          .timeout(timeOutDuration);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        favoriteProducts.remove(product);
        update();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
