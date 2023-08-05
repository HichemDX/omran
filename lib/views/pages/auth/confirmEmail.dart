
import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/auth/auth_controller.dart';
import 'package:bnaa/models/user.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/inputs/inputTextField.dart';

class ConfirmEmail extends StatefulWidget {
  ConfirmEmail();

  @override
  State<ConfirmEmail> createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  bool isCustomer = true;
  bool spinner = false;
  String code = "";
  User? userd;
  final formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthProvider());

  @override
  void initState() {
    super.initState();
  }

  sendCode() async {
    Loader.show(context, progressIndicator: LoaderStyleWidget());
    bool result = await authController.sendCode();
    Loader.hide();
  }

  confirmEmail() async {
    Loader.show(context, progressIndicator: LoaderStyleWidget());
    bool result = await authController.confirmEmail(code);
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
            'Confirmation Email'.tr,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => authController.logout(),
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        body: spinner
            ? Center(
                child: LoaderStyleWidget(),
              )
            : SingleChildScrollView(
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
                            'Code de confirmation'.tr,
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
                        SizedBox(
                          height: 50,
                        ),
                        InkWell(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                // login(context);
                                confirmEmail();
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
                                "Preuve".tr,
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
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 12),
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
