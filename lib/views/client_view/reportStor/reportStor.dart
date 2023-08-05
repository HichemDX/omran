
import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/auth/auth_controller.dart';
import 'package:bnaa/controllers/client_controllers/store_details_controller.dart';
import 'package:bnaa/models/store.dart';
import 'package:bnaa/views/widgets/image_holder.dart';
import 'package:bnaa/views/widgets/inputs/inputTextField.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReportStor extends StatefulWidget {
  final Store store;
  ReportStor({required this.store});

  @override
  State<ReportStor> createState() => _ReportStorState();
}

class _ReportStorState extends State<ReportStor> {
  String reportType = "";
  String content = "";
  final formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthProvider());
  final storeDetailsController = Get.put(StoreController());

  @override
  void initState() {
    super.initState();
  }

  ReportStor() async {
    Loader.show(context, progressIndicator: LoaderStyleWidget());
    bool result = await storeDetailsController.sendReport(
      content: content,
      reportType: reportType,
      storId: widget.store.id!,
    );
    if (result == true) {
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
            'Rapport'.tr,
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
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(52, 103, 128, 1)
                            .withOpacity(.2),
                        border: const Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(52, 103, 128, 1), width: 1),
                        )),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: CachedNetworkImage(
                            errorWidget: (ctx, _, __) => imageHolder,
                            imageUrl: "${widget.store.image}",
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 28.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.store.name}",
                                style: TextStyle(
                                  color: AppColors.BLACK_TEXT_COLOR,
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Type de Rapport'.tr,
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
                    keyboardType: TextInputType.text,
                    valueStater: (value) {
                      reportType = value;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Contenu'.tr,
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
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    valueStater: (value) {
                      content = value;
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          ReportStor();
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
                          "Envoyer".tr,
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
