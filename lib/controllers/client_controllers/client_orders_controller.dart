import 'dart:convert';

import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/order.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CommandController extends GetxController {
  List<Order> commands = [];
  Order? selectedCommand;

  bool isLoading = false;

  Future<List<Order>> getCommands(page) async {
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/commands?page=$page")
          .timeout(timeOutDuration);
      print(response.body);
      if (response.statusCode == 200) {
        (json.decode(response.body)['commands'] as List).map((i) => print(i));
        commands = (json.decode(response.body)['commands'] as List)
            .map((i) => Order.fromJson(i))
            .toList();

        return commands;
      } else {
        return Future.error("");
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<bool> confirmCommand(data) async {
    try {
      Network api = Network();
      var response = await api
          .postWithHeader(apiUrl: "/confirmation_commande", data: data)
          .timeout(timeOutDuration);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        commands.add(Order.fromJson(json.decode(response.body)[0]));
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

  Future<Order> getCommandById(String commandeId) async {
    try {
      isLoading = true;
      update();
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/info_command?commande_id=$commandeId")
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

  Future<bool> cancelOrder(orderId) async {
    print(orderId);
    try {
      Network api = Network();
      var response = await api.postWithHeader(
          apiUrl: "/cancel_order",
          data: {"order_id": orderId}).timeout(timeOutDuration);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        /* selectedCommand!.status = "CANCELED";
        print(commands.indexWhere((element) => element.id == orderId));
        commands[commands.indexWhere((element) => element.id == orderId)].status = "CANCELED";
        update();*/
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  selectCommand(command) {
    selectedCommand = command;
  }
}
