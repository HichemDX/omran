import 'package:bnaa/models/commune.dart';
import 'package:bnaa/models/wilaya.dart';
import 'package:get/get.dart';

class StoresFilterController extends GetxController {
  Wilaya? wilaya;
  List<Commune> communes = [];

  setWilaya({wilaya}) async {
    communes.clear();
    this.wilaya = wilaya;
    update();
  }

  setCommune({commune}) async {
    communes.add(commune);
    update();
  }

  deleteCommune({communeId}) {
    communes.removeWhere((element) => element.id == communeId);
    update();
  }

  initWilaya() {
    wilaya = null;
    update();
  }
}
