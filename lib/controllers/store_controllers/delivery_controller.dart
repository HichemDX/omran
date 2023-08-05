import 'dart:convert';

import 'package:bnaa/services/api_http.dart';
import 'package:get/get.dart';

import '../../models/delivery.dart';

class DeliveryController extends GetxController {
  List wilayas = <DeliveryWilaya>[];

  List<Rx<DeliveryCommune>> communes = <Rx<DeliveryCommune>>[];

  bool isLoading = false;
  RxBool isLoading2 = false.obs;

  Future<List<DeliveryWilaya>?> getDeliveryWilaya() async {
    final api = Network();
    isLoading = true;
    update();
    try {
      final res =
          await api.getWithHeader(apiUrl: "/store/get_delivery_wilayas");
      print('get delivery wilaya');
      print(res.statusCode);
      if (res.statusCode == 200) {
        print(res.body);
        wilayas = ((json.decode(res.body)) as List)
            .map((e) => DeliveryWilaya.fromJson(e))
            .toList();
        isLoading = false;
        update();
        return wilayas as List<DeliveryWilaya>;
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      isLoading = false;
      update();
    }
    return null;
  }

  Future<void> addDeliveryWilaya(
      {required int wilayaId, required int price}) async {
    final api = Network();
    try {
      final res = await api.postWithHeader(
        apiUrl: "/store/add_wilayas",
        // im passing array of Map bcz the body of this endpoint is like this
        data: [
          {
            "price": price,
            "wilaya": wilayaId,
          }
        ],
      );
      print(res.statusCode);
      if (res.statusCode == 201) {
        print(res.body);
        wilayas = (json.decode(res.body)['delivery_wilayas'] as List)
            .map((e) => DeliveryWilaya.fromJson(e))
            .toList();
        update();
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> updatePriceCommuneOrWilaya(
      {required int? communeId,
      required int? wilayaId,
      required int price}) async {
    final api = Network();
    isLoading2.value = true;
    try {
      final res = await api.postWithHeader(
        apiUrl: "/store/update_commune_wilaya",
        data: {
          "price": price,
          "wilaya": wilayaId,
          "commune": communeId,
        },
      );
      isLoading2.value = false;
      print('update commune');
      print(res.statusCode);
      if (res.statusCode == 201) {
        print(res.body);
        wilayas = (json.decode(res.body)['delivery_wilayas'] as List)
            .map((e) => DeliveryWilaya.fromJson(e))
            .toList();
        update();
      }
    } catch (error) {
      print(error);
      isLoading2.value = false;
    }
  }

  Future<void> deleteCommuneOrWilaya({
    required int? communeId,
    required int? wilayaId,
  }) async {
    final api = Network();
    isLoading = true;
    update();
    try {
      final res = await api.postWithHeader(
        apiUrl: "/store/delete_communes",
        data: {
          "wilaya": wilayaId,
          "commune": communeId,
        },
      );
      isLoading = false;
      update();
      print('delete commune');
      print(res.statusCode);
      if (res.statusCode == 200) {
        print(res.body);
        wilayas = (json.decode(res.body)['delivery_wilayas'] as List)
            .map((e) => DeliveryWilaya.fromJson(e))
            .toList();
        update();
      }
    } catch (error) {
      print(error);
      isLoading = false;
      update();
    }
    isLoading = false;
    update();
  }
}


