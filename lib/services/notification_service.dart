import 'dart:developer';
import 'package:bnaa/services/local_notification_service.dart';
import 'package:bnaa/views/client_view/client_notifications_page/client_notifications_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationService {

  final FirebaseMessaging _fcm;
  static String? token;
  PushNotificationService(this._fcm);


  Future initialise() async {
    token = await _fcm.getToken();
    log(token!);
    // Clipboard.setData(ClipboardData(text: token));
    /*User.refrechFireBaseToken({
      'notification_token' : token
    });*/

    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setBool('is_activate_notification', true);

    LocalNotificationService.initialize();
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: false,

    );

    _fcm.getInitialMessage();

    FirebaseMessaging.onMessage.listen((message) async {
      print("Notification received");
      print('Message data: ${message.data}');
      LocalNotificationService.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Get.to(ClientNotificationsPage());
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });


    _fcm.onTokenRefresh.listen((newToken) {
      /*User.refrechFireBaseToken({
        'notification_token' : newToken
      });*/
    });

  }
}
