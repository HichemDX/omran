import 'dart:developer';

import 'package:bnaa/controllers/cart_controller.dart';
import 'package:bnaa/controllers/client_controllers/client_orders_controller.dart';
import 'package:bnaa/controllers/client_controllers/profile_controller.dart';
import 'package:bnaa/controllers/commune_select_controller.dart';
import 'package:bnaa/controllers/wilaya_select_controller.dart';
import 'package:bnaa/models/commune.dart';
import 'package:bnaa/models/delivery.dart';
import 'package:bnaa/models/wilaya.dart';
import 'package:bnaa/views/client_view/client_orders_page/order_confirmed_page.dart';
import 'package:bnaa/views/pages/commande/components/command_item_widget.dart';
import 'package:bnaa/views/widgets/inputs/input_select_commune.dart';
import 'package:bnaa/views/widgets/inputs/input_select_wilaya_store_filter.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../main.dart';
import '../../widgets/appBar/appBar.dart';
import '../../widgets/inputs/inputTextField.dart';

class ConfirmOrderPage extends StatefulWidget {
  late int cartIndex;

  ConfirmOrderPage({required this.cartIndex});

  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  final AuthProvider authController = Get.find();
  final CartController cartController = Get.find();

  final wilayasController = Get.put(WilayaSelectController());

  final communeController = Get.put(CommuneSelectController());
  final commandController = Get.put(CommandController());

  ProfileController profileController = Get.find();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? completeName;
  String? phoneNumber;
  String? route;
  int? wilayaId;
  int? communeId;
  DeliveryWilaya? wilayaDelivery;

  _confirmCommand() async {
    if (_formKey.currentState!.validate()) {
      print('validate form');
      Loader.show(context, progressIndicator: LoaderStyleWidget());
      var data = {
        'nom': completeName!,
        'phone': phoneNumber!,
        'wilaya_id': wilayaId,
        'commune_id': communeId,
        'route': route!,
        'commandes': [
          cartController.cartsMap[widget.cartIndex.toString()]!.toJson()
        ],
      };
      log("data confirm commande: $data");
      bool res = await commandController.confirmCommand(data);
      Loader.hide();
      if (res) {
        //Get.off(OrderConfirmedPage());
        cartController.removeCart(storeId: widget.cartIndex);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      /* SharedPreferences storage = await SharedPreferences.getInstance();
      user= json.decode(storage.getString('user')!);*/
      //setState(() {});
      print(user);
      bool cond = cartController.cartsMap[widget.cartIndex.toString()]!
              .listProducts![0].deliveryWilayas.isNotEmpty &&
          wilayaId != null;
      log('cond  :  $cond');
      cartController.setDeliverability(cond);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_COLOR,
      appBar: AppBarWidget(
          title: 'confirmation de commande', icon: 'assets/icons/return.svg'),
      body: GetBuilder<ProfileController>(
        builder: (profile) {
          /*     communeId = profile.user!.commune!.id;
        wilayaId = profile.user!.wilaya!.id;
 */
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35.w),
                      child: Column(
                        children: [
                          SizedBox(height: 32.h),
                          Text(
                            'informations'.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20.sp),
                          ),
                          SizedBox(height: 9.h),
                          Text(
                            'Ajouter vos informations pour vous contacter'.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 14.sp),
                          ),
                          SizedBox(height: 22.h),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'full name'.tr,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.BLUE_COLOR,
                              ),
                            ),
                          ),
                          InputTextField(
                            initValue: user['name'],
                            hintText: "Entrez votre nom".tr,
                            valueStater: (value) {
                              completeName = value;
                            },
                          ),
                          SizedBox(height: 20.h),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'phone'.tr,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.BLUE_COLOR,
                              ),
                            ),
                          ),
                          InputTextField(
                            initValue: user['phone'],
                            hintText: "Entrez votre téléphone".tr,
                            keyboardType: TextInputType.phone,
                            valueStater: (value) {
                              phoneNumber = value;
                            },
                          ),
                          SizedBox(height: 20.h),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'address'.tr,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.BLUE_COLOR,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FutureBuilder<List<Wilaya>>(
                                future:
                                    wilayasController.initWilayaController(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Wilaya>> snapshot) {
                                  if (snapshot.hasData) {
                                    return InputSelectWilayaStoreFilter(
                                      hintText: 'wilaya'.tr,
                                      initValue: '',
                                      list: snapshot.data!,
                                      width: 160.w,
                                      onSelected: (Wilaya value) async {
                                        wilayaId = value.id;
                                        log('value  :  ${value.id}');
                                        bool cond = false;
                                        try {
                                          wilayaDelivery = cartController
                                              .cartsMap[
                                                  widget.cartIndex.toString()]!
                                              .listProducts![0]
                                              .deliveryWilayas
                                              .where((element) =>
                                                  element.wilaya.id == value.id)
                                              .toList()
                                              .first;
                                        } catch (error) {
                                          print(error);
                                          wilayaDelivery = null;
                                        }
                                        cartController.setDeliverability(
                                          wilayaDelivery != null,
                                          wilayaDelivery != null
                                              ? wilayaDelivery!.defaultPrice
                                              : 0,
                                        );
                                        await communeController
                                            .getCommunes(value.id);
                                      },
                                    );
                                  }
                                  return InputSelectWilayaStoreFilter(
                                    hintText: 'wilaya'.tr,
                                    initValue: '',
                                    list: [],
                                    isLoading: true,
                                    width: 160.w,
                                  );
                                },
                              ),
                              GetBuilder<CommuneSelectController>(
                                builder: (_) {
                                  if (communeController.isLoading) {
                                    return InputSelectCommune(
                                      hintText: 'commune'.tr,
                                      list: [],
                                      isLoading: true,
                                      onChange: (value) {
                                        print('commune');
                                        print(value.id);
                                        communeId = value.id;
                                      },
                                      width: 160.w,
                                    );
                                  }
                                  return InputSelectCommune(
                                    width: 160.w,
                                    hintText: 'commune'.tr,
                                    list: communeController.selectedCommunes,
                                    onChange: (Commune value) {
                                      communeId = value.id;

                                      /// set deliverability
                                      bool cond = false;
                                      num? deliveryPrice;
                                      if (wilayaDelivery == null) {
                                        cartController.setDeliverability(false);
                                        return;
                                      } else {
                                        DeliveryCommune? communeDelivery;
                                        try {
                                          communeDelivery = wilayaDelivery!
                                              .communes!
                                              .where((element) =>
                                                  element.commune.id ==
                                                  value.id)
                                              .toList()
                                              .first;
                                        } catch (e) {
                                          communeDelivery = null;
                                        }

                                        cartController.setDeliverability(
                                          communeDelivery == null
                                              ? (wilayaDelivery != null)
                                              : true,
                                          communeDelivery != null
                                              ? communeDelivery.price
                                              : (wilayaDelivery != null
                                                  ? wilayaDelivery!.defaultPrice
                                                  : 0),
                                        );
                                      }

                                      //     print('commune');
                                      //     print(value.id);
                                      //     communeId = value.id;

                                      //     /// set deliverability
                                      //     bool cond = false;
                                      //     num? deliveryPrice;
                                      //     try {
                                      //       DeliveryWilaya wilaya = cartController
                                      //           .cartsMap[
                                      //               widget.cartIndex.toString()]!
                                      //           .listProducts![0]
                                      //           .deliveryWilayas
                                      //           .firstWhere((element) =>
                                      //               element.wilaya.id == wilayaId);

                                      //       bool cond1 = wilaya.communes!
                                      //           .where((commune) =>
                                      //               commune.price !=
                                      //               wilaya.defaultPrice).toList()
                                      //           .isEmpty;

                                      //       if (cond1) {
                                      //         cond = true;
                                      //         deliveryPrice = wilaya.defaultPrice;
                                      //       } else {
                                      //         cond = wilaya.communes!
                                      //             .where((commune) =>
                                      //                 commune.price !=
                                      //                 wilaya.defaultPrice)
                                      //             .map((e) => e.commune.id)
                                      //             .contains(value.id);
                                      //         deliveryPrice = wilaya.communes!
                                      //             .where((commune) =>
                                      //                 commune.price !=
                                      //                 wilaya.defaultPrice)
                                      //             .firstWhere((element) =>
                                      //                 element.commune.id ==
                                      //                 value.id)
                                      //             .price;
                                      //       }
                                      //     } catch (error, trace) {
                                      //       print(error);
                                      //       //print(trace);
                                      //     }

                                      //     log('cond : $cond');
                                      //     if (cartController.isDeliverable ==
                                      //         true) {
                                      //       cartController.setDeliverability(
                                      //           cond,
                                      //           cond && deliveryPrice != null
                                      //               ? deliveryPrice
                                      //               : 0.0);
                                      //     }
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          InputTextField(
                            initValue: user['address'],
                            hintText: "Route".tr,
                            valueStater: (value) {
                              route = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    GetBuilder<CartController>(
                      builder: (_) {
                        if (cartController.cartsMap.isEmpty) {
                          return Container();
                        }
                        return CommandItemWidget(
                          model: cartController
                              .cartsMap[widget.cartIndex.toString()]!,
                          isDeliverable: cartController.isDeliverable,
                        );
                      },
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              GetBuilder<AuthProvider>(builder: (authController) {
                return ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      print('validate form');
                      Loader.show(context,
                          progressIndicator: LoaderStyleWidget());
                      var data = {
                        'nom': completeName!,
                        'phone': phoneNumber!,
                        'wilaya_id': wilayaId,
                        'commune_id': communeId,
                        'route': route!,
                        'commandes': [
                          {
                            "store_id": cartController
                                .cartsMap[widget.cartIndex.toString()]!.storeId,
                            "shipping_cost": cartController.deliveryPrice,
                            "products": cartController
                                .cartsMap[widget.cartIndex.toString()]!
                                .listProducts!
                                .map(
                                  (e) => {
                                    "id": e.id,
                                    "quantity": e.qtySelect,
                                  },
                                )
                                .toList(),
                          },
                        ],
                      };
                      print("data confirm commande: $data");
                      log("data confirm commande: $data");
                      bool res = await commandController.confirmCommand(data);

                      print('confirm command res = $res');
                      Loader.hide();

                      if (res) {
                        Get.off(OrderConfirmedPage(widget.cartIndex));
                        cartController.removeCart(storeId: widget.cartIndex);
                      }
                    }
                  },
                  child: Text('Acheter'.tr),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
