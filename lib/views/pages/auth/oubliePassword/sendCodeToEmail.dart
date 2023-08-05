
import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/auth/auth_controller.dart';
import 'package:bnaa/views/pages/auth/oubliePassword/changePassword.dart';
import 'package:bnaa/views/widgets/inputs/inputTextField.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SendCodeToEmail extends StatefulWidget {
  SendCodeToEmail();

  @override
  State<SendCodeToEmail> createState() => _SendCodeToEmailState();
}

class _SendCodeToEmailState extends State<SendCodeToEmail> {
  String email = "";
  final formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthProvider());

  @override
  void initState() {
    super.initState();
  }

  sendCode() async {
    Loader.show(context, progressIndicator: LoaderStyleWidget());
    bool result = await authController.sendCodeForChangePassword(email);
    if (result == true) {
      Get.to(ChangePassword(email: email));
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
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                  ),
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
                  InputTextField(
                    initValue: "",
                    hintText: '',
                    keyboardType: TextInputType.emailAddress,
                    valueStater: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          sendCode();
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
                          "Envoyer le code".tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
