import 'dart:convert';
import 'dart:developer';
import 'package:bnaa/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/product.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:get/get.dart';

class StoreProductsController extends GetxController {
  List<Product> products = [];
  Product? selectedProduct;

  List<Category> categories = [];

  selectProduct(product) {
    selectedProduct = product;
  }

  Future<List<Product>> getProducts({page = 1}) async {
    if (page == 1) {
      products.clear();
    }
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/products?page=$page")
          .timeout(timeOutDuration);
      log("response : ${response.body}");
      if (response.statusCode == 200) {
        products.addAll((json.decode(response.body) as List)
            .map((i) => Product.fromJson(i))
            .toList());

        return products;
      } else {
        return Future.error("");
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<List<Category>> getStoreCategories(storeId) async {
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/categories_by_store/$storeId")
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

  Future<List<Product>> getProductsByCategory(page, categoryId, storeId) async {
    if (page == 1) {
      products.clear();
    }
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(
              apiUrl:
                  "/products_stor/?stor_id=$storeId&category_id=$categoryId&page=$page")
          .timeout(timeOutDuration);
      log("response : ${response.body}");
      if (response.statusCode == 200) {
        // define pagination params

        products.addAll((json.decode(response.body) as List)
            .map((i) => Product.fromJson(i))
            .toList());
        return products;
      } else {
        return Future.error("");
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<bool> addProduct({data, filesPath}) async {
    try {
      Network api = Network();
      var streamResponse = await api
          .uploadFilePost(
              apiUrl: "/products/store",
              data: data,
              fileData: "images[]",
              filePath: filesPath)
          .timeout(timeOutDuration);

      log("add product data : $data ,\n file:$filesPath");
      log("add product statusCode : ${streamResponse.statusCode}");
      var response = await http.Response.fromStream(streamResponse);
      log("add product response : ${response.body}");
      if (streamResponse.statusCode == 200) {
        update();
        bool isAdded = json.decode(response.body)['result'];
        if (isAdded) {}
        return isAdded;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateProduct({data, filesPath}) async {
    try {
      Network api = Network();
      var streamResponse = await api
          .uploadFilePost(
              apiUrl: "/products/update",
              data: data,
              fileData: "images[]",
              filePath: filesPath)
          .timeout(timeOutDuration);
      log("update product data  : $data \n file : $filesPath ");

      var response = await http.Response.fromStream(streamResponse);
      log("update product status code : ${streamResponse.statusCode} \n response : ${response.body}");
      if (streamResponse.statusCode == 200 ||
          streamResponse.statusCode == 201) {
        bool isAdded = json.decode(response.body)['result'];

        if (isAdded) {
          products = await getProducts();
          update();
        }

        return isAdded;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteProduct({required productId}) async {
    try {
      Network api = Network();
      var response = await api.postWithHeader(
          apiUrl: "/product/delete",
          data: {"product_id": productId}).timeout(timeOutDuration);
      if (response.statusCode == 200) {
        products.removeWhere((element) => element.id == productId);
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

  Future<bool> deleteImageProduct({required imageId}) async {
    print(imageId);
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/products/image/delete/$imageId")
          .timeout(timeOutDuration);
      log("link :${"/products/image/delete/$imageId"} \n delete image : ${response.body} \n status code :${response.statusCode}");
      if (response.statusCode == 200) {
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
