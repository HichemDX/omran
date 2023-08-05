import 'dart:convert';

import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/store.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:get/get.dart';

class StoresController extends GetxController {
  List<Store> stores = [];
  bool isLoading = false;

  Future<List<Store>> getStores({int page = 1}) async {
    stores.clear();
    isLoading = true;
    update();
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/magasins?page=$page")
          .timeout(timeOutDuration);
      if (response.statusCode == 200) {
        stores = (json.decode(response.body) as List)
            .map((i) => Store.fromJson(i))
            .toList();

        isLoading = false;
        print("length stores : ${stores.length}");
        update();
        return stores;
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

  Future<List<Store>> getStoresWithFilter({
    String? wilayaId,
    List<String>? communeList,
  }) async {
    stores.clear();
    isLoading = true;
    update();
    String request = "&wilaya[]=$wilayaId";
    if (communeList!.isNotEmpty) {
      communeList.forEach((element) {
        request += "&commune[]=$element";
      });
    }
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(
              apiUrl:
                  "/magasins/?page=1$request" /*&wilaya=$wilayaId&commune=$communeList*/)
          .timeout(timeOutDuration);
      print(response.statusCode);
      if (response.statusCode == 200) {
        stores = (json.decode(response.body)/*["stores"]*/ as List)
            .map((i) => Store.fromJson(i))
            .toList();
        isLoading = false;
        update();
        return stores;
      } else {
        isLoading = false;
        update();
        return Future.error("rani");
      }
    } catch (e, t) {
      isLoading = false;
      update();
      print(e);
      print(t);
      return Future.error(e);
    }
  }
}
