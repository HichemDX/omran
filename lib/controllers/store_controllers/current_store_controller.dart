import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/store.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:bnaa/services/server_response.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentStoreController extends GetxController {
  Store? store;
  bool isLoading = false;
  Map<String, dynamic> appInfo = {};

  Future<Store> loadFromStorage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> json = jsonDecode(pref.getString('store')!);
    store = Store.fromJson(json);
    return store!;
  }

  Future<Store> getStoreDetails() async {
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/store/get_my_info")
          .timeout(timeOutDuration);
      print(response.body);
      if (response.statusCode == 200) {
        store = Store.fromJson(json.decode(response.body));
        return store!;
      } else {
        return Future.error("");
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future getAppInfo() async {
    try {
      Network api = Network();
      var response =
          await api.getWithHeader(apiUrl: "/info_app").timeout(timeOutDuration);
      print("get my info");
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        appInfo = jsonDecode(response.body);
      } else {
        return Future.error("");
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return Future.error("");
    }
  }

  Future<bool> updateStoreInfo(
      {required Map<String, String> data, imageFile}) async {
    print(data);
    Network api = Network();
    try {
      var streamResponse = await api
          .miltipartPost(
              apiUrl: '/store/set_my_info',
              data: data,
              filePath: imageFile,
              fileData: "image")
          .timeout(timeOutDuration);
      var response = await http.Response.fromStream(streamResponse);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201) {
        store = Store.fromJson(json.decode(response.body));
        update();
        return true;
      } else {
        ServerResponse.serverResponseHandler(response: response);
        return false;
      }
    } catch (e) {
      log(e.toString());
      ServerResponse.checkNetworkError();
      return false;
    }
  }
}
