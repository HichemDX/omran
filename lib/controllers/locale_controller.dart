import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends GetxController {
  @override
  void onInit() {
    initLocaleController();
    super.onInit();
  }

  Locale _locale = const Locale('fr', 'FR');

  Locale get locale => _locale;

  initLocaleController() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? locale = storage.getString('locale');
    if (locale != null) {
      _locale = Locale(locale);
      await Get.updateLocale(_locale);
    }
  }

  Future<void> setLocale(Locale localee) async {
    await Get.updateLocale(localee);
    SharedPreferences storage = await SharedPreferences.getInstance();
    _locale = localee;
    await storage.setString('locale', _locale.toString());

    update();
  }
}
