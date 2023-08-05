import 'dart:convert';

import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../services/api_http.dart';
import '../../widgets/appBar/appBar.dart';

class TermAndConditionPage extends StatelessWidget {
  TermAndConditionController termController =
      Get.put(TermAndConditionController());

  String? html;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'term and condition'.tr,
        icon: 'assets/icons/return.svg',
      ),
      body: Padding(
        padding: EdgeInsets.all(30.sp),
        child: FutureBuilder(
          future: termController.getTerms(),
          builder: (context, snapShot) {
            return GetBuilder<TermAndConditionController>(
              builder: (_) => termController.isLoading
                  ? Center(child: LoaderStyleWidget())
                  : termController.terms.isEmpty
                      ? Center(child: Text('no result found'.tr))
                      : SingleChildScrollView(
                          child: Html(
                            data: Get.locale?.languageCode == 'fr'
                                ? termController.terms['body_fr'].toString()
                                : termController.terms['body_ar'].toString(),
                          ),
                        ),
            );
          },
        ),
      ),
    );
  }
}

class TermAndConditionController extends GetxController {
  Map<String, dynamic> terms = {};
  bool isLoading = false;

  Future<void> getTerms() async {
    isLoading = true;
    update();
    try {
      Network api = Network();
      var response =
          await api.getWithHeader(apiUrl: "/Termes").timeout(timeOutDuration);
      print(response.statusCode);
      if (response.statusCode == 200) {
        terms = json.decode(response.body);
        isLoading = false;
        update();
      }
    } catch (e) {
      print(e);
      isLoading = false;
      update();
    }
  }
}
