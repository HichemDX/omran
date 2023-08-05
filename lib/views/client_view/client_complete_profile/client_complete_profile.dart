import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/auth/auth_controller.dart';
import 'package:bnaa/controllers/commune_select_controller.dart';
import 'package:bnaa/controllers/wilaya_select_controller.dart';
import 'package:bnaa/models/user.dart';
import 'package:bnaa/models/wilaya.dart';
import 'package:bnaa/services/image_picker_service.dart';
import 'package:bnaa/views/widgets/buttons/NormalButton.dart';
import 'package:bnaa/views/widgets/inputs/input_select_commune_store_filter.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/normalButtonModel.model.dart';
import '../../widgets/image_holder.dart';
import '../../widgets/inputs/input_select_wilaya_store_filter.dart';
import '../../widgets/inputs/inputTextField.dart';

class ClientCompleteProfile extends StatefulWidget {
  @override
  State<ClientCompleteProfile> createState() => _ClientCompleteProfileState();
}

class _ClientCompleteProfileState extends State<ClientCompleteProfile> {
  File? imageFile;

  final wilayasController = Get.put(WilayaSelectController());
  final communeController = Get.put(CommuneSelectController());
  final AuthProvider authController = Get.find();

  String? tradeName;
  String? phone;
  String? wilayaId;
  String? communeId;
  String? address;

  var formKey = GlobalKey<FormState>();

  _completeStoreProfile() async {
    if (formKey.currentState!.validate()) {
      Map<String, String> data = {
        "name": tradeName!,
        "phone": phone!,
        "commune": communeId!,
        "route": address!,
      };

      Loader.show(context, progressIndicator: LoaderStyleWidget());
      authController
          .completeClientProfile(data: data, imageFile: imageFile)
          .then((value) {
        log("${value}");
        Loader.hide();
      }).catchError((error) {
        print(error);
      });
    }
  }

  Future<User> getCurrentClient() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> json = jsonDecode(pref.getString('client')!);
    print(json);
    return User.fromJson(json);
  }

  _pickImage() async {
    final pickedImage = await ImagePickerService.getImageFromGallery();

    imageFile = File(pickedImage.path);
    if (imageFile != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.BACK_COLOR,
        body: FutureBuilder<User>(
          future: getCurrentClient(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 20.h),
                              Text(
                                'add picture'.tr,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.BLUE_COLOR,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              imageFile != null
                                  ? Center(
                                      child: SizedBox(
                                        height: 130,
                                        width: 130,
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              height: 130,
                                              width: 130,
                                              child: Image.file(
                                                imageFile!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Center(
                                              child: InkWell(
                                                onTap: () {
                                                  _pickImage();
                                                },
                                                child: Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.grey
                                                      .withOpacity(0.9),
                                                  size: 50,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 130,
                                      width: 130,
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            height: 130,
                                            width: 130,
                                            child: CachedNetworkImage(
                                              errorWidget: (ctx, _, __) =>
                                                  imageHolder,
                                              imageUrl:
                                                  "${snapShot.data!.pictureLink}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Center(
                                            child: InkWell(
                                              onTap: () {
                                                _pickImage();
                                              },
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: Colors.grey
                                                    .withOpacity(0.9),
                                                size: 50,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                              SizedBox(height: 13.h),
                            ],
                          ),
                        ),
                        // Text(
                        //   'email'.tr,
                        //   style: TextStyle(
                        //       fontSize: 12.sp,
                        //       fontWeight: FontWeight.w600,
                        //       color: AppColors.BLUE_COLOR),
                        // ),
                        // InputTextField(
                        //   initValue: snapShot.data!.email,
                        //   hintText: '',
                        //   valueStater: (val) {},
                        // ),
                        SizedBox(height: 20.h),
                        Text(
                          'full name'.tr,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.BLUE_COLOR,
                          ),
                        ),
                        InputTextField(
                          initValue: snapShot.data!.name,
                          hintText: '',
                          valueStater: (value) {
                            tradeName = value;
                          },
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'phone'.tr,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.BLUE_COLOR,
                          ),
                        ),
                        InputTextField(
                          hintText: 'EX : 0556547741',
                          initValue: snapShot.data!.phone,
                          isPhone: true,
                          keyboardType: TextInputType.number,
                          valueStater: (value) {
                            phone = value;
                          },
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'address'.tr,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.BLUE_COLOR,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder<List<Wilaya>>(
                                future:
                                    wilayasController.initWilayaController(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Wilaya>> snapshot) {
                                  if (snapshot.hasData) {
                                    return InputSelectWilayaStoreFilter(
                                      hintText: 'wilaya'.tr,
                                      list: snapshot.data!,
                                      width: 160.w,
                                      onSelected: (value) {
                                        communeController.getCommunes(value.id);
                                      },
                                    );
                                  }
                                  return InputSelectWilayaStoreFilter(
                                    hintText: 'wilaya'.tr,
                                    list: [],
                                    isLoading: true,
                                    width: 160.w,
                                  );
                                }),
                            GetBuilder<CommuneSelectController>(
                              builder: (_) {
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
                                  width: 160.w,
                                  onChange: (value) {
                                    communeId = value.id.toString();
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        InputTextField(
                          hintText: 'address'.tr,
                          valueStater: (value) {
                            address = value;
                          },
                        ),
                        SizedBox(height: 20.h),
                        Center(
                          child: NormalButton(
                            model: NormalButtomModel(
                              textFontSize: 16.sp,
                              colorText: Colors.white,
                              colorButton: AppColors.BLUE_COLOR,
                              width: MediaQuery.of(context).size.width,
                              onTap: () {
                                _completeStoreProfile();
                              },
                              height: 42.h,
                              radius: 10.r,
                              text: 'continue'.tr,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Center(child: LoaderStyleWidget());
          },
        ),
      ),
    );
  }
}
