import 'dart:convert';

import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/commune.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:get/get.dart';

class CommuneSelectController extends GetxController {
  Map<String, List<Commune>> communesMap = {};
  List<Commune> selectedCommunes = [];
  bool isLoading = false;

  Future<List<Commune>> getCommunes(wilayaId) async {
    selectedCommunes.clear();
    isLoading = true;
    update();
    if (communesMap[wilayaId.toString()] == null) {
      try {
        Network api = Network();
        var response = await api
            .get("/commune/?wilaya_id=$wilayaId")
            .timeout(timeOutDuration);
        if (response.statusCode == 200) {
          communesMap[wilayaId.toString()] =
              (json.decode(response.body) as List)
                  .map((i) => Commune.fromJson(i))
                  .toList();
          selectedCommunes.addAll(communesMap[wilayaId.toString()]!);
          isLoading = false;
          update();
          return communesMap[wilayaId.toString()]!;
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
    selectedCommunes.addAll(communesMap[wilayaId.toString()]!);
    isLoading = false;
    update();
    return communesMap[wilayaId.toString()]!;
  }
}
