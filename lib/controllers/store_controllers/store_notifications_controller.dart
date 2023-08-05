import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../constants/constants.dart';
import '../../models/store_notification.dart';
import '../../services/api_http.dart';

class StoreNotificationController extends GetxController {
  List<StoreNotificationModel> notifications = [];

  bool isLoading = false;

  Future<List<StoreNotificationModel>> getNotifications() async {
    isLoading = true;
    update();
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/store/notifications")
          .timeout(timeOutDuration);
      print(response.body);
      if (response.statusCode == 200) {
        notifications = (json.decode(response.body) as List)
            .map((i) => StoreNotificationModel.fromJson(i))
            .toList();
        isLoading = false;
        update();

        return notifications;
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

  Future markAsRead({required int idNotification}) async {
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(
          apiUrl:
          "/store/notification_read?notification_id=$idNotification")
          .timeout(timeOutDuration);
      print(response.body);
      if (response.statusCode == 201) {
        notifications
            .firstWhere((element) => element.id == idNotification)
            .read = "1";
        update();

        return json.decode(response.body)['result'];
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}