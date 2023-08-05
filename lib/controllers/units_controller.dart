import 'dart:convert';

import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/unit.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:get/get.dart';

class UnitsController extends GetxController {
  List<Unit> units = [];

  Future<List<Unit>> getUnits() async {
    if (units.isEmpty) {
      try {
        Network api = Network();
        var response = await api
            .getWithHeader(apiUrl: "/unites")
            .timeout(timeOutDuration);
        print(response.body);
        if (response.statusCode == 200) {
          units = (json.decode(response.body) as List)
              .map((i) => Unit.fromJson(i))
              .toList();

          return units;
        } else {
          return Future.error("");
        }
      } catch (e) {
        print(e);
        return Future.error(e);
      }
    }
    return units;
  }
}
