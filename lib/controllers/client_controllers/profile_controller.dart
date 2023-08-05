import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/user.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bnaa/main.dart' as main;

class ProfileController extends GetxController {
  User? user;

  Map<String, dynamic> appInfo = {};

  loadFromStorage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('user') != null) {
      Map<String, dynamic> json = jsonDecode(pref.getString('user')!);
      main.user = jsonDecode(pref.getString('user')!);
      user = User.fromJson(json);
    }
  }

  Future<User> getUserProfile() async {
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/get_my_info")
          .timeout(timeOutDuration);
      print("get my info");
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        await userStorageUpdate(response.body);
        await loadFromStorage();
        return user!;
      } else {
        return Future.error("");
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return Future.error("");
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

  Future<bool> updateUserProfile({Map<String, String>? data, filePath}) async {
    print(data);
    try {
      Network api = Network();
      var streamResponse = await api
          .miltipartPost(
              apiUrl: "/set_my_info",
              data: data,
              filePath: filePath,
              fileData: 'image')
          .timeout(timeOutDuration);
      var response = await http.Response.fromStream(streamResponse);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await userStorageUpdate(response.body);
        await loadFromStorage();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static userStorageUpdate(String response) async {
    var data = json.decode(response);
    print((data));
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('user', json.encode(data));
  }

  @override
  void onInit() {
    loadFromStorage();
    super.onInit();
  }
}
