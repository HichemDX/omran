
import 'package:bnaa/controllers/auth/auth_controller.dart';
import 'package:bnaa/views/pages/auth/oubliePassword/sendCodeToEmail.dart';
import 'package:bnaa/views/pages/auth/signupScreen.dart';
import 'package:bnaa/views/widgets/inputs/inputTextField.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bnaa/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String? phone;
  String? password;
  final formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthProvider());

  Future<void> login(context) async {
    Loader.show(context, progressIndicator: LoaderStyleWidget());
    try {
      bool result = await authController.firstLogin(
        phone!,
        password!,
      );
      Loader.hide();
      final status = authController.status;
      if (result == true) {
        // var type = await accountTypeDialog(context);
        // print(type);
        // if (type == 'S') {
        //   Loader.show(context, progressIndicator: LoaderStyleWidget());

        //   try {
        //     await authController.storeLogin(email!, password!);
        //     Loader.hide();
        //   } catch (error) {
        //     print(error);
        //     Loader.hide();
        //   }
        // }
        // if (type == 'C') {
        //   Loader.show(context, progressIndicator: LoaderStyleWidget());
        //   try {
        //     await authController.clientLogin(email!, password!);
        //     Loader.hide();
        //   } catch (error) {
        //     print(error);
        //     Loader.hide();
        //   }
        // }
      }
    } catch (error) {
      print(error);
      Loader.hide();
    }
  }

  static accountTypeDialog(context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Continuez tanque :',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.BLUE_COLOR,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, 'S');
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
                                color: const Color.fromRGBO(234, 199, 71, 1),
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
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 35.w),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, 'C');
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
                                color: const Color.fromRGBO(234, 199, 71, 1),
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
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  DateTime? lastPressed;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        const maxDuration = Duration(seconds: 2);
        bool isWarning =
            lastPressed == null || now.difference(lastPressed!) > maxDuration;
        if (isWarning) {
          lastPressed = DateTime.now();
          final snackBar = SnackBar(
            content: Text('Appuyer deux fois pour sortir'.tr),
            duration: maxDuration,
            backgroundColor: AppColors.BLUE_COLOR,
          );
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.BACK_COLOR,
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 70),
                    Image.asset('assets/icons/logo.png', scale: 10),
                    /*Text('Logo', style: TextStyle(fontSize: 12.sp)),*/
                    SizedBox(height: 40.h),
                    Text(
                      'sign in'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 20.sp),
                    ),
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
                      hintText: 'Ex : 0555555555',
                      keyboardType: TextInputType.phone,
                      valueStater: (value) {
                        phone = value;
                      },
                    ),
                    SizedBox(height: 30.h),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Password'.tr,
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
                      obscureText: !showPassword,
                      suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        child: Icon(
                          showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                      valueStater: (value) {
                        password = value;
                      },
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            login(context);
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
                            'sign in'.tr,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                    SizedBox(height: 7.h),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(SendCodeToEmail());
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Mot de passe oublié?'.tr,
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (contect) {
                          return SignUpScreen();
                        }));
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          'Créez un nouveau Compte'.tr,
                          style: TextStyle(color: Colors.blue, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
