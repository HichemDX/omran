import 'dart:convert';

import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/category.dart';
import 'package:bnaa/models/order.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:get/get.dart';

class StoreOrdersController extends GetxController {
  Map<String, String> commandStatus = {
    "all": 'all',
    "PENDING": 'pending',
    "PROCESSING": 'accepted',
    "PREPARED": 'charged',
    "DISPATCHED": 'on the way',
    "DELIVERED": 'delivered',
    "CANCELED": 'canceled'
  };

  List<Order> commands = [];
  List<Category> categories = [];
  String statusKey = "all";

  bool isLoading = false;

  Order? selectedCommand;

  selectCommand(id) {
    selectedCommand = commands.firstWhere((element) => element.id == id);
  }

  Future<List<Order>> getStoreCommands({int page = 1}) async {
    try {
      isLoading = true;
      update();
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/orders?page=$page")
          .timeout(timeOutDuration);
      if (response.statusCode == 200) {
        commands = (json.decode(response.body) as List)
            .map((i) => Order.fromJson(i))
            .toList();

        isLoading = false;
        update();

        return commands;
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

  Future<List<Order>> getStoreCommandsByStatus() async {
    print(statusKey);
    try {
      isLoading = true;
      update();
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/orders?page=1&status=$statusKey")
          .timeout(timeOutDuration);
      if (response.statusCode == 200) {
        commands = (json.decode(response.body) as List)
            .map((i) => Order.fromJson(i))
            .toList();

        isLoading = false;
        update();
        return commands;
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

  Future<Order> getStoreCommandById(String commandeId) async {
    try {
      isLoading = true;
      update();
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/one_order?commande_id=$commandeId")
          .timeout(timeOutDuration);
      if (response.statusCode == 200) {
        Order command = Order.fromJson(json.decode(response.body));

        isLoading = false;
        update();

        return command;
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

  selectStatus(statusKey) {
    this.statusKey = statusKey;
    update();

    if (statusKey == "all") {
      getStoreCommands();
    } else {
      getStoreCommandsByStatus();
    }
  }

  Future<bool> changeCommandStatus({orderId, status}) async {
    try {
      print(status);
      Network api = Network();
      var response = await api.postWithHeader(
        apiUrl: "/order/change_status",
        data: {
          "order_id": selectedCommand != null ? selectedCommand!.id : orderId,
          "status": status,
        },
      ).timeout(timeOutDuration);
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 201) {
        print('okkkk');
        selectedCommand!.status = status;
        print(selectedCommand!.status);
        print(commands
            .indexWhere((element) => element.id == selectedCommand!.id));
        commands[commands.indexWhere((element) => element.id == orderId)] =
            selectedCommand!;
        update();
        return true;
      } else {
        return false;
      }
    } catch (e, t) {
      print(e);
      print(t);
      return false;
    }
  }
}
