import 'dart:io';

import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/client_controllers/profile_controller.dart';
import 'package:bnaa/controllers/commune_select_controller.dart';
import 'package:bnaa/controllers/wilaya_select_controller.dart';
import 'package:bnaa/models/normalButtonModel.model.dart';
import 'package:bnaa/models/normalButtonWithBorderModel.model.dart';
import 'package:bnaa/models/wilaya.dart';
import 'package:bnaa/services/image_picker_service.dart';
import 'package:bnaa/views/widgets/appBar/appBar.dart';
import 'package:bnaa/views/widgets/buttons/NormalButton.dart';
import 'package:bnaa/views/widgets/buttons/normalButtonWithBorder.dart';
import 'package:bnaa/views/widgets/inputs/input_select_commune_store_filter.dart';
import 'package:bnaa/views/widgets/inputs/input_select_wilaya_store_filter.dart';
import 'package:bnaa/views/widgets/inputs/inputTextField.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ClientEditProfilePage extends StatefulWidget {
  @override
  State<ClientEditProfilePage> createState() => _ClientEditProfilePageState();
}

class _ClientEditProfilePageState extends State<ClientEditProfilePage> {
  final wilayasController = Get.put(WilayaSelectController());
  final communeController = Get.put(CommuneSelectController());

  ProfileController profileController = Get.put(ProfileController());
  String? name;
  String? phone;
  String? route;
  String? communeId;
  File? imageFile;

  final formKey = GlobalKey<FormState>();

  _updateProfile() async {
    if (formKey.currentState!.validate()) {
      Map<String, String> data = {
        "name": name.toString(),
        "phone": phone.toString(),
        'commune': communeId.toString(),
        "route": route.toString(),
      };

      Loader.show(context, progressIndicator: LoaderStyleWidget());
      await profileController
          .updateUserProfile(data: data, filePath: imageFile)
          .then((value) {
        Loader.hide();
      });
    }
  }

  _pickImage() async {
    imageFile = await ImagePickerService.getImageFromGallery();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'profile settings',
        icon: 'assets/icons/return.svg',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: GetBuilder<ProfileController>(
          builder: (profile) {
            communeId = profile.user!.commune!.id.toString();
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 11.h),
                    InkWell(
                      onTap: () {
                        _pickImage();
                      },
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 168.sp,
                              width: 168.sp,
                              child: profileController.user!.pictureLink ==
                                      'https://omran-dz.com/icons/user.png'
                                  ? Image.asset(
                                      'assets/icons/profile2.png',
                                      fit: BoxFit.cover,
                                      height: 100.sp,
                                      width: 100.sp,
                                    )
                                  : imageFile != null
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
                                      : CachedNetworkImage(
                                          height: 168.sp,
                                          width: 168.sp,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "${profileController.user!.pictureLink}",
                                        ),
                            ),
                            Container(
                              height: 72.sp,
                              width: 72.sp,
                              child:
                                  SvgPicture.asset('assets/icons/camera.svg'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      'full name'.tr,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.BLUE_COLOR),
                    ),
                    InputTextField(
                      hintText: 'full name'.tr,
                      initValue: profile.user!.name,
                      valueStater: (value) {
                        name = value;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'phone'.tr,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.BLUE_COLOR),
                    ),
                    InputTextField(
                        hintText: 'phone'.tr,
                        initValue: profile.user!.phone,
                        valueStater: (value) {
                          phone = value;
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'address'.tr,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.BLUE_COLOR),
                    ),
                    InputTextField(
                        hintText: 'address'.tr,
                        initValue: profile.user!.address,
                        valueStater: (value) {
                          route = value;
                        }),
                    SizedBox(
                      height: 10.h,
                    ),
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
                                  initValue: Get.locale!.languageCode == "fr"
                                      ? profile.user!.wilaya!.nameFr
                                      : profile.user!.wilaya!.nameAr,
                                  list: snapshot.data!,
                                  width: 160.w,
                                  onSelected: (value) {
                                    communeController.getCommunes(value.id);
                                  },
                                );
                              }
                              return InputSelectWilayaStoreFilter(
                                hintText: 'wilaya'.tr,
                                initValue: Get.locale!.languageCode == "fr"
                                    ? profile.user!.wilaya!.nameFr
                                    : profile.user!.wilaya!.nameAr,
                                list: [],
                                isLoading: true,
                                width: 160.w,
                              );
                            }),
                        GetBuilder<CommuneSelectController>(builder: (_) {
                          if (communeController.isLoading) {
                            return InputSelectCommuneStoreFilter(
                              initValue: Get.locale!.languageCode == "fr"
                                  ? profile.user!.commune!.nameFr
                                  : profile.user!.commune!.nameAr,
                              hintText: 'commune'.tr,
                              list: [],
                              isLoading: true,
                              width: 160.w,
                            );
                          }
                          return InputSelectCommuneStoreFilter(
                            initValue: Get.locale!.languageCode == "fr"
                                ? profile.user!.commune!.nameFr
                                : profile.user!.commune!.nameAr,
                            hintText: 'commune'.tr,
                            list: communeController.selectedCommunes,
                            width: 160.w,
                            onChange: (value) {
                              communeId = value.id;
                            },
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: 0.h),
                    InputTextField(hintText: 'Rue'.tr),
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
                            height: 48.h,
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
                              onTap: () {
                                _updateProfile();
                              },
                              height: 48.h,
                              radius: 10.r,
                              text: 'save'.tr),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
