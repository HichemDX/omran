import 'dart:convert';

import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/faq.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:get/get.dart';

class FaqController extends GetxController{

  List<Faq> faqs = [];
  Future<List<Faq>> getFaqs() async {
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: "/questions")
          .timeout(timeOutDuration);
      print(response.body);
      if (response.statusCode == 200) {
        faqs = (json.decode(response.body) as List)
            .map((i) => Faq.fromJson(i))
            .toList();

        return faqs;
      } else {
        return Future.error("");
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }

  }
}