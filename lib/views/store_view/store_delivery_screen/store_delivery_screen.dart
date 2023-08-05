import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/store_controllers/delivery_controller.dart';
import 'package:bnaa/views/widgets/buttons/NormalButton.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/wilaya_select_controller.dart';
import '../../../models/delivery.dart';
import '../../../models/normalButtonModel.model.dart';
import '../../../models/wilaya.dart';
import '../../widgets/appBar/appBar.dart';
import '../../widgets/inputs/input_select_wilaya_store_filter.dart';

class StoreDeliveryScreen extends StatefulWidget {
  const StoreDeliveryScreen({Key? key}) : super(key: key);

  @override
  State<StoreDeliveryScreen> createState() => _StoreDeliveryScreenState();
}

class _StoreDeliveryScreenState extends State<StoreDeliveryScreen> {
  final deliveryController = Get.put(DeliveryController());
  final wilayasController = Get.put(WilayaSelectController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  TextEditingController priceController = TextEditingController();

  int? wilayaId;

  @override
  void initState() {
    deliveryController.getDeliveryWilaya();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.BACK_COLOR,
      appBar:
          AppBarWidget(title: 'delivery'.tr, icon: 'assets/icons/return.svg'),
      body: GetBuilder<DeliveryController>(
        builder: (_) {
          return Stack(
            children: [
              Positioned.fill(
                child: deliveryController.wilayas.isEmpty
                    ? deliveryController.isLoading
                        ? Center(child: LoaderStyleWidget())
                        :  Center(child: Text("no result found".tr))
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: deliveryController.wilayas.length,
                        itemBuilder: (cx, index) {
                          DeliveryWilaya wilaya =
                              deliveryController.wilayas[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: ExpansionTile(
                              collapsedBackgroundColor: Colors.white,
                              backgroundColor: Colors.white,
                              iconColor: AppColors.BLUE_COLOR,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: buildTitle(wilaya),
                              subtitle: buildSubTitle(wilaya),
                              childrenPadding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              children: [
                                if (wilaya.communes != null &&
                                    wilaya.communes!.isNotEmpty)
                                  ...wilaya.communes!
                                      .where((DeliveryCommune commune) =>
                                          commune.price != wilaya.defaultPrice)
                                      .toSet()
                                      .map(buildCommuneItem)
                                      .toList(),
                                const SizedBox(height: 5),
                                buildAddCommuneButton(context, wilaya),
                                const SizedBox(height: 10),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (cx, index) =>
                            const SizedBox(height: 15),
                      ),
              ),
              Positioned(
                bottom: 60,
                right: 30,
                child: IconButton(
                  onPressed: showDialogAddWilaya,
                  icon: const Icon(
                    Icons.add_circle_rounded,
                    color: AppColors.BLUE_COLOR,
                    size: 60,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildTitle(wilaya) {
    return Row(
      children: [
        Text(
          Get.locale?.languageCode == 'fr'
              ? wilaya.wilaya.nameFr!
              : wilaya.wilaya.nameAr.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.BLUE_COLOR,
          ),
        ),
        const Spacer(),
        false /*deliveryController.isLoading*/
            ? LoaderStyleWidget()
            : InkWell(
                onTap: () async {
                  await deliveryController.deleteCommuneOrWilaya(
                    communeId: null,
                    wilayaId: wilaya.wilaya.id,
                  );
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
              ),
      ],
    );
  }

  Widget buildSubTitle(wilaya) {
    bool _isEmpty = (wilaya.communes!
            .where((DeliveryCommune commune) =>
                commune.price != wilaya.defaultPrice)
            .toList())
        .isEmpty;
    return Row(
      children: [
        Text(
          "${wilaya.defaultPrice} " + "da".tr,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.INACTIVE_GREY_COLOR,
          ),
        ),
        const SizedBox(width: 5),
        if (_isEmpty)
          Text(
            "(" + "Tout Communes".tr + ")",
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.INACTIVE_GREY_COLOR,
            ),
          ),
        const SizedBox(width: 15),
        InkWell(
          onTap: () {
            showDialogWilayaUpdatePrice(wilaya);
          },
          child: const Icon(
            Icons.edit,
            color: AppColors.BLUE_COLOR,
          ),
        ),
      ],
    );
  }

  Widget buildCommuneItem(DeliveryCommune commune) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      color: AppColors.BLUE_OPACITY,
      child: Row(
        children: [
          InkWell(
            onTap: () async {
              await deliveryController.deleteCommuneOrWilaya(
                communeId: commune.commune.id!,
                wilayaId: null,
              );
            },
            child: false /*deliveryController.isLoading*/
                ? LoaderStyleWidget()
                : const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
          ),
          const SizedBox(width: 10),
          Text(Get.locale?.languageCode == 'fr'
              ? commune.commune.nameFr!
              : commune.commune.nameAr.toString()),
          const Spacer(),
          Text("${commune.price}"),
          const SizedBox(width: 5),
          InkWell(
            onTap: () {
              showDialogCommuneUpdatePrice(commune);
            },
            child: const Icon(
              Icons.edit,
              color: AppColors.BLUE_COLOR,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAddCommuneButton(context, DeliveryWilaya wilaya) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
          ),
          builder: (ctx) => buildBottomSheetWidget(ctx, wilaya),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          color: AppColors.BLUE_COLOR,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          'Ajouter Commune'.tr,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildCommuneBottomSheetItem(ctx, wilaya, index) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: deliveryController.communes[index].value.price !=
                    wilaya.defaultPrice
                ? null
                : () async {
                    await showDialogCommuneUpdatePrice(
                        deliveryController.communes[index].value);
                    Navigator.of(ctx).pop();
                  },
            child: Icon(
              wilaya.communes![index].price == wilaya.defaultPrice
                  ? Icons.add
                  : Icons.check,
              size: 40,
              color: wilaya.communes![index].price == wilaya.defaultPrice
                  ? AppColors.BLUE_COLOR
                  : Colors.greenAccent,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              Get.locale?.languageCode == 'fr'
                  ? deliveryController.communes[index].value.commune.nameFr!
                  : deliveryController.communes[index].value.commune.nameAr
                      .toString(),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const Spacer(),
          Material(
            elevation: 2,
            child: SizedBox(
              width: 100,
              height: 30,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'enter price'.tr;
                  }
                  return null;
                },
                readOnly: true,
                keyboardType: TextInputType.none,
                decoration: InputDecoration(
                  hintText: deliveryController.communes[index].value.price ==
                          wilaya.defaultPrice
                      ? "price".tr
                      : deliveryController.communes[index].value.price
                          .toString(),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomSheetWidget(BuildContext ctx, DeliveryWilaya wilaya) {
    List<DeliveryCommune> oldCommunes = wilaya.communes!;
    deliveryController.communes = [];
    oldCommunes.forEach((element) {
      DeliveryCommune e = element;
      deliveryController.communes.add(e.obs);
    });

    return Obx(
      () => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              ...List.generate(
                deliveryController.communes.length,
                (index) => buildCommuneBottomSheetItem(ctx, wilaya, index),
              ).toList()
            ],
          ),
        ),
      ),
    );
  }

  Future showDialogAddWilaya() async {
    return showDialog(
      context: context,
      builder: (c) {
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FutureBuilder<List<Wilaya>>(
                  future: wilayasController.initWilayaController(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Wilaya>> snapshot) {
                    if (!snapshot.hasData) {
                      return InputSelectWilayaStoreFilter(
                        hintText: 'wilaya'.tr,
                        list: const [],
                        isLoading: true,
                        width: 160.w,
                      );
                    }
                    return InputSelectWilayaStoreFilter(
                      hintText: 'wilaya'.tr,
                      list: snapshot.data!,
                      width: double.infinity,
                      onSelected: (Wilaya value) {
                        wilayaId = value.id;
                        print('wilaya id : $wilayaId');
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: priceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  style: TextStyle(fontSize: 14.sp),
                  validator: (value) {
                    if (value == null) {
                      return 'enter price'.tr;
                    }
                    return null;
                  },
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'price'.tr,
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                NormalButton(
                  model: NormalButtomModel(
                    textFontSize: 16.sp,
                    colorText: Colors.white,
                    colorButton: AppColors.BLUE_COLOR,
                    width: MediaQuery.of(context).size.width,
                    onTap: () async {
                      if (_formKey.currentState!.validate() &&
                          wilayaId != null) {
                        await deliveryController.addDeliveryWilaya(
                          wilayaId: wilayaId!,
                          price: int.parse(priceController.text),
                        );
                        priceController.clear();
                        Navigator.of(c).pop();
                      }
                    },
                    height: 42.h,
                    radius: 10.r,
                    text: 'continue'.tr,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future showDialogCommuneUpdatePrice(DeliveryCommune commune) async {
    return await showDialog(
      context: context,
      builder: (c) {
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Get.locale?.languageCode == 'fr'
                    ? commune.commune.nameFr!
                    : commune.commune.nameAr.toString()),
                const SizedBox(height: 10),
                TextFormField(
                  controller: priceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  style: TextStyle(fontSize: 14.sp),
                  validator: (value) {
                    if (value == null) {
                      return 'enter price'.tr;
                    }
                    return null;
                  },
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'price'.tr,
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                deliveryController.isLoading2.value
                    ? LoaderStyleWidget()
                    : NormalButton(
                        model: NormalButtomModel(
                          textFontSize: 16.sp,
                          colorText: Colors.white,
                          colorButton: AppColors.BLUE_COLOR,
                          width: MediaQuery.of(context).size.width,
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await deliveryController
                                  .updatePriceCommuneOrWilaya(
                                communeId: commune.commune.id!,
                                wilayaId: null,
                                price: int.parse(
                                  priceController.text,
                                ),
                              );
                              priceController.clear();
                              Navigator.of(c).pop();
                            }
                          },
                          height: 42.h,
                          radius: 10.r,
                          text: 'continue'.tr,
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }

  Future showDialogWilayaUpdatePrice(DeliveryWilaya wilaya) async {
    return await showDialog(
      context: context,
      builder: (c) {
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Get.locale?.languageCode == 'fr'
                    ? wilaya.wilaya.nameFr!
                    : wilaya.wilaya.nameAr.toString()),
                const SizedBox(height: 10),
                TextFormField(
                  controller: priceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  style: TextStyle(fontSize: 14.sp),
                  validator: (value) {
                    if (value == null) {
                      return 'enter price'.tr;
                    }
                    return null;
                  },
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'price'.tr,
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                deliveryController.isLoading2.value
                    ? LoaderStyleWidget()
                    : NormalButton(
                        model: NormalButtomModel(
                          textFontSize: 16.sp,
                          colorText: Colors.white,
                          colorButton: AppColors.BLUE_COLOR,
                          width: MediaQuery.of(context).size.width,
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await deliveryController
                                  .updatePriceCommuneOrWilaya(
                                communeId: null,
                                wilayaId: wilaya.wilaya.id,
                                price: int.parse(
                                  priceController.text,
                                ),
                              );
                              priceController.clear();
                              Navigator.of(c).pop();
                            }
                          },
                          height: 42.h,
                          radius: 10.r,
                          text: 'continue'.tr,
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
