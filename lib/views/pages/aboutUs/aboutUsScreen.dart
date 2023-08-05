import 'dart:convert';

import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../services/api_http.dart';
import '../../widgets/appBar/appBar.dart';

class AboutUsPage extends StatelessWidget {
  AboutController aboutController = Get.put(AboutController());

  String? html;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'about us'.tr,
        icon: 'assets/icons/return.svg',
      ),
      body: Padding(
        padding: EdgeInsets.all(30.sp),
        child: FutureBuilder(
          future: aboutController.getAbout(),
          builder: (context, snapShot) {
            return GetBuilder<AboutController>(
              builder: (_) => aboutController.isLoading
                  ? Center(child: LoaderStyleWidget())
                  : aboutController.about.isEmpty
                      ? const Center(child: Text('No Condition Added'))
                      : SingleChildScrollView(
                          child: Html(
                            data: Get.locale?.languageCode == 'fr'
                                ? aboutController.about['body_fr'].toString()
                                : aboutController.about['body_ar'].toString(),
                          ),
                        ),
            );
          },
        ),
      ),
    );
  }
}

class AboutController extends GetxController {
  Map<String, dynamic> about = {};
  bool isLoading = false;

  Future<void> getAbout() async {
    isLoading = true;
    update();
    try {
      Network api = Network();
      var response =
          await api.getWithHeader(apiUrl: "/about").timeout(timeOutDuration);
      print(response.statusCode);
      if (response.statusCode == 200) {
        about = json.decode(response.body);
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
