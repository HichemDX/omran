import 'dart:convert';

import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/order.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:get/get.dart';

class CommandDetailsController extends GetxController {
  Order? command;

  Future<Order> getCommandDetails(commandId) async {
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/info_commande?commande_id=$commandId")
          .timeout(timeOutDuration);
      if (response.statusCode == 200) {
        command = Order.fromJson(json.decode(response.body));

        return command!;
      } else {
        return Future.error("");
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
