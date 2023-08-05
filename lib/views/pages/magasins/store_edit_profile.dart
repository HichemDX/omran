import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/commune_select_controller.dart';
import 'package:bnaa/controllers/wilaya_select_controller.dart';
import 'package:bnaa/models/normalButtonModel.model.dart';
import 'package:bnaa/models/normalButtonWithBorderModel.model.dart';
import 'package:bnaa/models/store.dart';
import 'package:bnaa/models/wilaya.dart';
import 'package:bnaa/views/widgets/appBar/appBar.dart';
import 'package:bnaa/views/widgets/buttons/NormalButton.dart';
import 'package:bnaa/views/widgets/buttons/normalButtonWithBorder.dart';
import 'package:bnaa/views/widgets/inputs/inputTextField.dart';
import 'package:bnaa/views/widgets/inputs/input_select_commune_store_filter.dart';
import 'package:bnaa/views/widgets/inputs/input_select_wilaya_store_filter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class UserEditProfile extends StatefulWidget {
  Store store;
  UserEditProfile({Key? key,required this.store}) : super(key: key);

  @override
  _UserEditProfileState createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  final wilayasController = Get.put(WilayaSelectController());
  final communeController = Get.put(CommuneSelectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
          title: 'edit'.tr, icon: 'assets/icons/return.svg'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 23.h),
              Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.clear,
                    size: 22.sp, color: Color.fromRGBO(0, 15, 150, 1)),
              ),
              SizedBox(height: 11.h),
              InkWell(
                onTap: () {},
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 168.sp,
                        width: 168.sp,
                        child: CachedNetworkImage(
                            height: 168.sp,
                            width: 168.sp,
                            fit: BoxFit.cover,
                            imageUrl:
                            'https://upload.wikimedia.org/wikipedia/commons/a/a0/Pierre-Person.jpg'),
                      ),
                      Container(
                        height: 72.sp,
                        width: 72.sp,
                        child: SvgPicture.asset('assets/icons/camera.svg'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'email'.tr,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.BLUE_COLOR),
              ),
              InputTextField(
                hintText: 'yacinebendou@gmail.com',
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Nom',
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.BLUE_COLOR),
              ),
              InputTextField(
                hintText: 'yacinebendou',
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Prénom',
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.BLUE_COLOR),
              ),
              InputTextField(
                hintText: 'yacinebendou',
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'phone'.tr,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.BLUE_COLOR),
              ),
              InputTextField(
                hintText: 'yacinebendou',
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'address'.tr,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.BLUE_COLOR),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                FutureBuilder<List<Wilaya>>(
                    future: wilayasController.initWilayaController(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Wilaya>> snapshot) {
                      if (snapshot.hasData) {
                        print(widget.store.wilaya!.nameFr);
                        return InputSelectWilayaStoreFilter(
                          hintText: 'wilaya'.tr,
                          list: snapshot.data!,
                          initValue: widget.store.wilaya!.nameFr,
                          width: 160.w,
                          onSelected: (value){
                            communeController.getCommunes(value.id);
                          },
                        );
                      }
                      return InputSelectWilayaStoreFilter(
                        hintText: 'wilaya'.tr,
                        list: [],
                        initValue: widget.store.wilaya!.nameFr,
                        isLoading: true,
                        width: 160.w,
                      );
                    }),
                GetBuilder<CommuneSelectController>(builder: (_) {
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
                    initValue: widget.store.commune!.nameFr,
                    width: 160.w,
                    onChange: (value){
                      
                    },
                  );
                }),
              ]),
              SizedBox(
                height: 0.h,
              ),
              InputTextField(
                hintText: 'Rue'.tr,
              ),
              SizedBox(
                height: 50.h,
              ),
              Row(
                children: [
                  NormalButtonWithBorder(
                    model: NormalButtonWithBorderModel(
                      textFontSize: 16.sp,
                      colorText: AppColors.BLUE_COLOR,
                      bColor: AppColors.BLUE_COLOR,
                      colorButton: Colors.white,
                      width: 150.w,
                      wBorder: 1.sp,
                      onTap: () {},
                      height: 42.h,
                      radius: 10.r,
                      text: 'cancel'.tr,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  NormalButton(
                    model: NormalButtomModel(
                        textFontSize: 16.sp,
                        colorText: Colors.white,
                        colorButton: AppColors.BLUE_COLOR,
                        width: 150.w,
                        onTap: () {},
                        height: 42.h,
                        radius: 10.r,
                        text: 'save'.tr),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
