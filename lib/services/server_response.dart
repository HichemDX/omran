import 'dart:convert';

import 'package:bnaa/services/toast_service.dart';
import 'package:http/http.dart' as http;

class ServerResponse {
  //static final context = MyApp.navigatorKey.currentContext;

  static serverResponseHandler({required http.Response response}) async {
    switch (response.statusCode) {
      case 401:
        print('logout');
        ToastService.showErrorToast(json.decode(response.body)['message']);
        break;
      case 500:
        ToastService.showErrorToast(
          "Somthing wrong",
        );
        break;
      default:
        ToastService.showErrorToast(json.decode(response.body)['message']);
        break;
    }
  }

  static checkNetworkError() async {
    ToastService.showErrorToast(
      "Check you internet connection",
    );
  }
}
