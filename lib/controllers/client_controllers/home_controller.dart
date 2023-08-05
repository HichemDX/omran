import 'dart:convert';

import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/category.dart';
import 'package:bnaa/models/slider.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:bnaa/view_models/home_view_model.dart';
import 'package:bnaa/view_models/product_home_model.dart';
import 'package:get/get.dart';

import '../notification_controller.dart';

class HomeController extends GetxController {
  HomeViewModel? homeViewModel;

  final clientNotifController = Get.put(NotificationController());

  bool isNotif = false;

  Future<bool> initHomeController() async {
    try {
      Network api = Network();
      var response =
          await api.getWithHeader(apiUrl: "/home").timeout(timeOutDuration);
      if (response.statusCode == 200) {
        print(jsonDecode(response.body)['categories']);
        List<HomeSlider> homeSlider =
            (jsonDecode(response.body)['slider'] as List).isNotEmpty
                ? (jsonDecode(response.body)['slider'] as List)
                    .map((i) => HomeSlider.fromJson(i))
                    .toList()
                : [];

        print(jsonDecode(response.body)['categories']);
        List<Category> categories =
            (jsonDecode(response.body)['categories'] as List)
                .map((i) => Category.fromJson(i))
                .toList();

        List<ProductHomeModel> productsByCategories =
            (jsonDecode(response.body)['products_with_category'] as List)
                .map((i) => ProductHomeModel.fromJson(i))
                .toList();

        homeViewModel = HomeViewModel(
          homeSlider: homeSlider,
          categories: categories,
          productsByCategories: productsByCategories,
        );

        final clientNotifications =
            await clientNotifController.getNotifications();
        isNotif = clientNotifications.isEmpty
            ? false
            : clientNotifications.any((element) => element.see == false)
                ? true
                : false;
        update();

        return true;
      } else {
        print("error initHome");
        return Future.error("");
      }
    } catch (e, stackTrace) {
      print("error initHome catch");
      print(e);
      print(stackTrace);
      return Future.error(e);
    }
  }
}
