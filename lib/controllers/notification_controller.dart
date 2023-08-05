import 'dart:convert';

import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/notification.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  List<NotificationModel> notifications = [];

  bool isLoading = false;

  Future<List<NotificationModel>> getNotifications() async {
    isLoading = true;
    update();
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/notifications")
          .timeout(timeOutDuration);
      print(response.body);
      if (response.statusCode == 200) {
        notifications = (json.decode(response.body) as List)
            .map((i) => NotificationModel.fromJson(i))
            .toList();

        isLoading = false;
        update();

        return notifications;
      } else {
        isLoading = false;
        update();
        return Future.error("");
      }
    } catch (e, t) {
      isLoading = false;
      update();
      print(e);
      print(t);
      return Future.error(e);
    }
  }

  Future markAsRead({required int idNotification}) async {
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(
              apiUrl: "/notification_read?notification_id=$idNotification")
          .timeout(timeOutDuration);
      print(response.body);
      if (response.statusCode == 201) {
        // await getNotifications();

        notifications
            .firstWhere((element) => element.id == idNotification)
            .see = true;
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
