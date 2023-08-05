
import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/auth/auth_controller.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../widgets/inputs/inputTextField.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen();

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isCustomer = true;

  String type = "C";
  String? tradeName;
  String? email;
  String? password;
  String? password2;
  final formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthProvider());

  inscription() async {
    if (password != password2) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Vérifiez le mot de passe".tr),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.blue,
      ));
      return;
    }
    Loader.show(context, progressIndicator: LoaderStyleWidget());

    bool result = await authController.register(
        name: tradeName!, phone: email!, password: password!, type: type);
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Compte créé avec succès".tr),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ));
      Loader.hide();

      Get.back();
    } else {}
    Loader.hide();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.BACK_COLOR,
        appBar: AppBar(
          backgroundColor: AppColors.BACK_COLOR,
          elevation: 0,
          title: Text(
            'Inscription'.tr,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            type = "S";
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/vendeurIcon.svg',
                                width: 50.sp,
                                height: 50.sp,
                                color: const Color.fromRGBO(234, 199, 71, 1),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                'seller'.tr,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.BACK_COLOR,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              width: 2.sp,
                              color: type == "S"
                                  ? const Color.fromRGBO(234, 199, 71, 1)
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 35.w),
                      InkWell(
                        onTap: () {
                          setState(() {
                            type = 'C';
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/clientIcon.svg',
                                width: 50.sp,
                                height: 50.sp,
                                color: const Color.fromRGBO(234, 199, 71, 1),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                'client'.tr,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14.sp,
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.BACK_COLOR,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              width: 2.sp,
                              color: type == "C"
                                  ? const Color.fromRGBO(234, 199, 71, 1)
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    type == "C" ? 'full name'.tr : 'trade name'.tr,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.BLUE_COLOR),
                  ),
                  InputTextField(
                      initValue: "",
                      hintText: '',
                      valueStater: (value) {
                        tradeName = value;
                      }),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'email'.tr,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.BLUE_COLOR,
                      ),
                    ),
                  ),
                  InputTextField(
                    initValue: "",
                    hintText: 'Ex : example@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    valueStater: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(height: 30.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Mot de passe'.tr,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.BLUE_COLOR,
                      ),
                    ),
                  ),
                  InputTextField(
                    initValue: "",
                    hintText: '*********',
                    obscureText: true,
                    valueStater: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(height: 30.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "Confirmation d'un mot de passe".tr,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.BLUE_COLOR,
                      ),
                    ),
                  ),
                  InputTextField(
                    initValue: "",
                    hintText: '*********',
                    obscureText: true,
                    valueStater: (value) {
                      password2 = value;
                    },
                  ),
                  SizedBox(height: 20.h),
                  InkWell(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          inscription();
                        }
                      },
                      child: Container(
                        height: 62.h,
                        width: 343.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.blue,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 4,
                              offset: Offset(0, 2), // Shadow position
                            ),
                          ],
                        ),
                        child: Text(
                          "s'inscrire".tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                  SizedBox(height: 7.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
