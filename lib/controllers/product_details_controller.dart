import 'dart:convert';

import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/product.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  Product? product;

  Future<Product> getCommandDetails(productId) async {
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/detail_product/?product_id=$productId")
          .timeout(timeOutDuration);
      if (response.statusCode == 200) {
        product = Product.fromJson(json.decode(response.body));

        return product!;
      } else {
        return Future.error("");
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
