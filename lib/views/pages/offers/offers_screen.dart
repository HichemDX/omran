import 'dart:convert';

import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../services/api_http.dart';
import '../../widgets/appBar/appBar.dart';

class OffersScreen extends StatelessWidget {
  OffersController offersController = Get.put(OffersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'offers'.tr,
        icon: 'assets/icons/return.svg',
      ),
      body: Padding(
        padding: EdgeInsets.all(30.sp),
        child: FutureBuilder(
          future: offersController.getOffers(),
          builder: (context, snapShot) {
            return GetBuilder<OffersController>(
              builder: (_) => offersController.isLoading
                  ? Center(child: LoaderStyleWidget())
                  : offersController.offers.isEmpty
                      ? Center(child: Text('no result found'.tr))
                      : ListView.separated(
                          itemCount: offersController.offers.length,
                          itemBuilder: (cx, index) {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.BLUE_COLOR2,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        offersController.offers[index].nameFr
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        offersController.offers[index].prix
                                                .toString() +
                                            " " +
                                            "da".tr,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        offersController.offers[index].days
                                                .toString() +
                                            " " +
                                            "days".tr,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    offersController.offers[index].descFr
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (cx, index) =>
                              const SizedBox(height: 10),
                        ),
            );
          },
        ),
      ),
    );
  }
}

class OffersController extends GetxController {
  List<Offer> offers = [];
  bool isLoading = false;

  Future<void> getOffers() async {
    isLoading = true;
    update();
    try {
      Network api = Network();
      var response =
          await api.get("/store/sliders_offers").timeout(timeOutDuration);
      print(response.statusCode);
      if (response.statusCode == 200) {
        offers = (json.decode(response.body) as List)
            .map((e) => Offer.fromJson(e))
            .toList();
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

class Offer {
  int? id;
  String? nameAr;
  String? nameFr;
  String? descAr;
  String? descFr;
  String? days;
  String? prix;

  Offer(
      {this.id,
      this.nameAr,
      this.nameFr,
      this.descAr,
      this.descFr,
      this.days,
      this.prix});

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameFr = json['name_fr'];
    descAr = json['desc_ar'];
    descFr = json['desc_fr'];
    days = json['days'];
    prix = json['prix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_fr'] = this.nameFr;
    data['desc_ar'] = this.descAr;
    data['desc_fr'] = this.descFr;
    data['days'] = this.days;
    data['prix'] = this.prix;
    return data;
  }
}
