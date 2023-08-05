import 'dart:convert';

import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/wilaya.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:get/get.dart';

class WilayaSelectController extends GetxController {
  List<Wilaya> wilayas = [];

  Future<List<Wilaya>> initWilayaController() async {
    if (wilayas.isEmpty) {
      try {
        Network api = Network();
        var response = await api.get("/wilaya").timeout(timeOutDuration);
        if (response.statusCode == 200) {
          wilayas = (json.decode(response.body) as List)
              .map((i) => Wilaya.fromJson(i))
              .toList();

          return wilayas;
        } else {
          return Future.error("");
        }
      } catch (e,stackTrace) {
        print('error');
        print(stackTrace);
        print(e);
        return Future.error(e);
      }
    }
    return wilayas;
  }
}
