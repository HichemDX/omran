import 'dart:io';

import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/commune_select_controller.dart';
import 'package:bnaa/controllers/store_controllers/current_store_controller.dart';
import 'package:bnaa/controllers/wilaya_select_controller.dart';
import 'package:bnaa/models/normalButtonModel.model.dart';
import 'package:bnaa/models/normalButtonWithBorderModel.model.dart';
import 'package:bnaa/models/store.dart';
import 'package:bnaa/models/wilaya.dart';
import 'package:bnaa/services/image_picker_service.dart';
import 'package:bnaa/views/widgets/appBar/appBar.dart';
import 'package:bnaa/views/widgets/buttons/NormalButton.dart';
import 'package:bnaa/views/widgets/buttons/normalButtonWithBorder.dart';
import 'package:bnaa/views/widgets/inputs/inputTextField.dart';
import 'package:bnaa/views/widgets/inputs/input_select_commune_store_filter.dart';
import 'package:bnaa/views/widgets/inputs/input_select_wilaya_store_filter.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class StoreEditProfile extends StatefulWidget {
  Store store;

  StoreEditProfile({Key? key, required this.store}) : super(key: key);

  @override
  _StoreEditProfileState createState() => _StoreEditProfileState();
}

class _StoreEditProfileState extends State<StoreEditProfile> {
  final wilayasController = Get.put(WilayaSelectController());
  final communeController = Get.put(CommuneSelectController());

  final CurrentStoreController storeController = Get.find();
  final formkey = GlobalKey<FormState>();

  String? name;
  String? phone;
  String? address;
  String? wilayaId;
  String? communeId;

  _updateStore() async {
    if (formkey.currentState!.validate()) {
      Loader.show(context, progressIndicator: LoaderStyleWidget());
      Map<String, String> data = {
        "name": "$name",
        "phone": "$phone",
        "email": "email@gmail.com",
        "commune":
            communeId != null ? communeId! : "${widget.store.commune!.id}",
        "address": "$address",
        "min_amount_order": "10",
        "longitude": "10",
        "latitude": "10",
      };

      try {
        var res = await storeController.updateStoreInfo(
          data: data,
          imageFile: imageFile,
        );
        Loader.hide();
        if (res) Get.back();
      } catch (error, stackTrace) {
        Loader.hide();
        print(error);
        print(stackTrace);
      }
    }
  }

  File? imageFile;

  _pickImage() async {
    final pickedImage = await ImagePickerService.getImageFromGallery();

    imageFile = File(pickedImage.path);
    if (imageFile != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(title: 'edit'.tr, icon: 'assets/icons/return.svg'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 23.h),
                SizedBox(height: 11.h),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      imageFile != null
                          ? Container(
                              height: 168.sp,
                              width: 168.sp,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: FileImage(imageFile!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 168.sp,
                              width: 168.sp,
                              child: 
                                widget.store.image! ==
                                  'https://omran-dz.com/icons/store.png'
                              ? Image.asset(
                                  'assets/icons/profilestore3.png',
                                  fit: BoxFit.cover,
                                  height: 100.sp,
                                  width: 100.sp,
                                )
                              
                              :CachedNetworkImage(
                                //errorWidget: (ctx, _, __) => imageHolder,
                                height: 168.sp,
                                width: 168.sp,
                                fit: BoxFit.cover,
                                imageUrl: widget.store.image!,
                              ),
                            ),
                      InkWell(
                        onTap: _pickImage,
                        child: SizedBox(
                          height: 72.sp,
                          width: 72.sp,
                          child: SvgPicture.asset('assets/icons/camera.svg'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  'store name'.tr,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.BLUE_COLOR),
                ),
                InputTextField(
                  hintText: 'EX : Benaa store',
                  initValue: widget.store.name,
                  valueStater: (value) {
                    name = value;
                  },
                ),
                SizedBox(height: 20.h),
                Text(
                  'phone'.tr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.BLUE_COLOR,
                  ),
                ),
                InputTextField(
                  initValue: widget.store.phone,
                  hintText: 'Ex : 0777000000',
                  keyboardType: TextInputType.phone,
                  valueStater: (value) {
                    phone = value;
                  },
                ),
                SizedBox(height: 20.h),
                Text(
                  'address'.tr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.BLUE_COLOR,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder<List<Wilaya>>(
                        future: wilayasController.initWilayaController(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Wilaya>> snapshot) {
                          if (snapshot.hasData) {
                            return InputSelectWilayaStoreFilter(
                              hintText: 'wilaya'.tr,
                              list: snapshot.data!,
                              initValue: Get.locale!.languageCode == "fr"
                                  ? widget.store.wilaya!.nameFr
                                  : widget.store.wilaya!.nameAr,
                              width: 160.w,
                              onSelected: (value) {
                                communeController.getCommunes(value.id);
                              },
                            );
                          }
                          return InputSelectWilayaStoreFilter(
                            hintText: 'wilaya'.tr,
                            list: [],
                            initValue: Get.locale!.languageCode == "fr"
                                ? widget.store.wilaya!.nameFr
                                : widget.store.wilaya!.nameAr,
                            isLoading: true,
                            width: 160.w,
                          );
                        }),
                    GetBuilder<CommuneSelectController>(
                      builder: (_) {
                        print("rebuild commune");
                        if (communeController.isLoading) {
                          return InputSelectCommuneStoreFilter(
                            hintText: 'commune'.tr,
                            list: [],
                            isLoading: true,
                            width: 160.w,
                          );
                        }
                        return InputSelectCommuneStoreFilter(
                          hintText: 'commune'.tr,
                          list: communeController.selectedCommunes,
                          initValue: Get.locale!.languageCode == "fr"
                              ? widget.store.commune!.nameFr
                              : widget.store.commune!.nameAr,
                          width: 160.w,
                          onChange: (value) {
                            communeId = value.id.toString();
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 0.h),
                InputTextField(
                  initValue: widget.store.addres,
                  hintText: 'Rue'.tr,
                  valueStater: (value) {
                    address = value;
                  },
                ),
                SizedBox(height: 50.h),
                Row(
                  children: [
                    NormalButtonWithBorder(
                      model: NormalButtonWithBorderModel(
                        textFontSize: 18.sp,
                        colorText: AppColors.BLUE_COLOR,
                        bColor: AppColors.BLUE_COLOR,
                        colorButton: Colors.white,
                        width: 150.w,
                        wBorder: 1.sp,
                        onTap: () {},
                        height: 45.h,
                        radius: 10.r,
                        text: 'cancel'.tr,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    NormalButton(
                      model: NormalButtomModel(
                        textFontSize: 18.sp,
                        colorText: Colors.white,
                        colorButton: AppColors.BLUE_COLOR,
                        width: 150.w,
                        onTap: _updateStore,
                        height: 45.h,
                        radius: 10.r,
                        text: 'save'.tr,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
