
import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/auth/auth_controller.dart';
import 'package:bnaa/views/widgets/inputs/inputTextField.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePassword extends StatefulWidget {
  final String email;
  ChangePassword({required this.email});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String email = "";
  String code = "";
  String password = "";
  String password2 = "";
  final formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthProvider());

  @override
  void initState() {
    super.initState();
  }

  sendCode() async {
    Loader.show(context, progressIndicator: LoaderStyleWidget());
    bool result = await authController.sendCodeForChangePassword(widget.email);
    Loader.hide();
  }

  changePassword() async {
    if (password != password2) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Vérifiez le mot de passe".tr),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.blue,
      ));
      return;
    }
    Loader.show(context, progressIndicator: LoaderStyleWidget());
    bool result = await authController.changePassword(
        email: email, code: code, password: password);
    if (result == true) {
      Get.back();
      Get.back();
    }
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
            'Changer le mot de passe'.tr,
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
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Email'.tr,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.BLUE_COLOR,
                      ),
                    ),
                  ),
                  IgnorePointer(
                    child: InputTextField(
                      initValue: "${widget.email}",
                      hintText: '',
                      keyboardType: TextInputType.emailAddress,
                      valueStater: (value) {
                        email = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Code'.tr,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.BLUE_COLOR,
                      ),
                    ),
                  ),
                  InputTextField(
                    initValue: "",
                    hintText: '',
                    keyboardType: TextInputType.phone,
                    valueStater: (value) {
                      code = value;
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
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          changePassword();
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
                          "Changement".tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      sendCode();
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Renvoyer le code de confirmation'.tr,
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
