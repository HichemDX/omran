import 'dart:convert';

import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/controllers/store_controllers/store_notifications_controller.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:get/get.dart';


class StoreHomeController extends GetxController {
  int orders = 0;
  int products = 0;

  final storeNotifController = Get.put(StoreNotificationController());

  bool isNotif = false;

  Future<bool> getStoreHome() async {
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/store/home")
          .timeout(timeOutDuration);

      if (response.statusCode == 200) {
        orders = json.decode(response.body)['orders'];
        products = json.decode(response.body)['products'];

        final storeNotifications =
            await storeNotifController.getNotifications();
        isNotif = (storeNotifications.isEmpty
            ? false
            : storeNotifications.any((element) => element.read == "0")
                ? true
                : false);
        update();

        return true;
      } else {
        update();
        return Future.error("");
      }
    } catch (e) {
      print(e);
      update();
      return Future.error(e);
    }
  }
}
