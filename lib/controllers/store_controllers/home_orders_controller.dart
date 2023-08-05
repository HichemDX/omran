import 'dart:convert';

import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/order.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:get/get.dart';

class HomeOrdersController extends GetxController {
  List<Order> orders = [];

  Future<List<Order>> getOrders({required page}) async {
    Network api = Network();
    var response = await api
        .getWithHeader(apiUrl: "/orders?page=$page")
        .timeout(timeOutDuration);
    print(response.body);
    if (response.statusCode == 200) {
      orders = (json.decode(response.body) as List)
          .map((i) => Order.fromJson(i))
          .toList();

      return orders;
    } else {
      return Future.error("");
    }
    /*try {

    } catch (e) {
      print(e);
      return Future.error(e);
    }*/
  }
}
