import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/auth/auth_controller.dart';
import 'package:bnaa/controllers/store_controllers/current_store_controller.dart';
import 'package:bnaa/models/store.dart';
import 'package:bnaa/views/pages/aboutUs/aboutUsScreen.dart';
import 'package:bnaa/views/pages/change_language_page/change_languages_page.dart';
import 'package:bnaa/views/pages/faq_page/faq_page.dart';
import 'package:bnaa/views/pages/termes_conditions_page/termes_conditions_page.dart';
import 'package:bnaa/views/store_view/store_edit_profile/store_edit_profile.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../pages/offers/offers_screen.dart';
import '../store_delivery_screen/store_delivery_screen.dart';
import '../store_notification_page/store_notification_page.dart';

class StoreSettingsDrawer extends StatelessWidget {
  final storeController = Get.put(CurrentStoreController());
  final AuthProvider authProvider = Get.put(AuthProvider());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Store>(
          future: storeController.getStoreDetails(),
          builder: (BuildContext context, AsyncSnapshot<Store> snapshot) {
            return FutureBuilder<Store>(
                future: storeController.loadFromStorage(),
                builder: (BuildContext context, AsyncSnapshot<Store> snapshot) {
                  if (snapshot.hasData) {
                    return GetBuilder<CurrentStoreController>(
                      builder: (_) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 27.h,
                            horizontal: 25.w,
                          ),
                          child: ListView(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 100.sp,
                                    width: 100.sp,
                                    child: 
                                    storeController.store!.image! ==
                                  'https://omran-dz.com/icons/store.png'
                              ? Image.asset(
                                  'assets/icons/profilestore3.png',
                                  fit: BoxFit.cover,
                                  height: 100.sp,
                                  width: 100.sp,
                                )
                              : 
                                    CachedNetworkImage(
                                      imageUrl: storeController.store!.image!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 28.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${storeController.store!.name}',
                                          style: TextStyle(
                                            color: AppColors.BLACK_TEXT_COLOR,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/phoneIcon.svg',
                                              height: 15.sp,
                                              width: 15.sp,
                                            ),
                                            SizedBox(width: 10.w),
                                            Text(
                                              '${storeController.store!.phone}',
                                              style: TextStyle(fontSize: 14.sp),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/locationIcon.svg',
                                              height: 15.sp,
                                              width: 15.sp,
                                            ),
                                            SizedBox(width: 10.w),
                                            Expanded(
                                              child: Text(
                                                Get.locale!.languageCode != "fr"
                                                    ? "${storeController.store!.wilaya!.nameAr ?? ""}, ${storeController.store!.commune!.nameAr ?? ""} "
                                                    : "${storeController.store!.wilaya!.nameFr},${storeController.store!.commune!.nameFr ?? ""}",
                                                style:
                                                    TextStyle(fontSize: 14.sp),
                                                maxLines:
                                                    1, // Limite le texte à une seule ligne
                                                overflow: TextOverflow
                                                    .ellipsis, // Ajoute des points de suspension (...) en cas de dépassement
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/locationIcon.svg',
                                              height: 15.sp,
                                              width: 15.sp,
                                              color: Colors.transparent,
                                            ),
                                            SizedBox(width: 10.w),
                                            
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 18.54.h),
                              Container(
                                  color: AppColors.BLUE_COLOR,
                                  width: double.infinity,
                                  height: 1.h),
                              SizedBox(
                                height: 49.h,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => StoreNotificationsPage());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/notifIconList.svg',
                                              width: 17.sp,
                                              height: 17.sp),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Text(
                                            'notifications'.tr,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight
                                                  .bold, // Add the bold font weight here
                                            ),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              devider(),
                              InkWell(
                                onTap: () {
                                  Get.to(() => StoreDeliveryScreen());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/deliveryIcon.svg',
                                            width: 15.sp,
                                            height: 15.sp,
                                          ),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Text(
                                            'delivery'.tr,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight
                                                  .bold, // Add the bold font weight here
                                            ),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              devider(),
                              InkWell(
                                onTap: () {
                                  Get.to(const ChangeLanguagePage());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/translationIcon.svg',
                                              width: 17.sp,
                                              height: 17.sp),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Text(
                                            'language'.tr,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight
                                                  .bold, // Add the bold font weight here
                                            ),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              devider(),
                              InkWell(
                                onTap: () {
                                  Get.to(FaqPage());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/questionIcon.svg',
                                              width: 17.sp,
                                              height: 17.sp),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Text(
                                            'faq'.tr,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight
                                                  .bold, // Add the bold font weight here
                                            ),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              devider(),
                              InkWell(
                                onTap: () => Get.to(() => AboutUsPage()),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/iIcon.svg',
                                              width: 17.sp,
                                              height: 17.sp),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Text(
                                            'about us'.tr,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight
                                                  .bold, // Add the bold font weight here
                                            ),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              devider(),
                              InkWell(
                                onTap: () =>
                                    Get.to(() => TermAndConditionPage()),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/loiIcon.svg',
                                              width: 17.sp,
                                              height: 17.sp),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Text(
                                            'term and condition'.tr,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight
                                                  .bold, // Add the bold font weight here
                                            ),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              devider(),
                              //SizedBox(height: 19.h),
                              InkWell(
                                onTap: () {
                                  Get.to(StoreEditProfile(
                                      store: storeController.store!));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/personParamIcon.svg',
                                              width: 17.sp,
                                              height: 17.sp),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Text(
                                            'profile settings'.tr,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight
                                                  .bold, // Add the bold font weight here
                                            ),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              devider(),

                              InkWell(
                                onTap: () => Get.to(() => OffersScreen()),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/personIcon.svg',
                                            width: 17.sp,
                                            height: 17.sp,
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            'offers'.tr,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight
                                                  .bold, // Add the bold font weight here
                                            ),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              devider(),
                              ElevatedButton(
                                onPressed: () {
                                  authProvider.logout();
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white, backgroundColor: Colors
                                      .red, // Text color
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 24),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/logoutIcon.svg',
                                      width: 17.sp,
                                      height: 17.sp,
                                      color: Colors
                                          .white, // Add the color property here
                                    ),
                                    SizedBox(width: 8.w),
                                    Text('logout'.tr,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.white)),
                                    SizedBox(width: 8.w),
                                  ],
                                ),
                              ),
                              SizedBox(height: 19.h),
                              FutureBuilder(
                                future: storeController.getAppInfo(),
                                builder: (context, _) {
                                  return storeController.appInfo.isEmpty
                                      ? Container()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                launchUrl(
                                                  Uri.parse(storeController
                                                      .appInfo['facebook']),
                                                );
                                              },
                                              child: Image.asset(
                                                'assets/icons/facebookIcon.png',
                                                height: 40.sp,
                                                width: 40.sp,
                                              ),
                                            ),
                                            SizedBox(width: 25.w),
                                            InkWell(
                                              onTap: () {
                                                launchUrl(
                                                  Uri.parse(storeController
                                                      .appInfo['instagram']),
                                                );
                                              },
                                              child: Image.asset(
                                                'assets/icons/instagramIcon.png',
                                                height: 40.sp,
                                                width: 40.sp,
                                              ),
                                            ),
                                            SizedBox(width: 25.w),
                                            InkWell(
                                              onTap: () {
                                                launchUrl(
                                                  Uri(
                                                      scheme: 'tel',
                                                      path: storeController
                                                          .appInfo['phone']),
                                                );
                                              },
                                              child: Image.asset(
                                                'assets/icons/whatsappIcon.png',
                                                height: 40.sp,
                                                width: 40.sp,
                                              ),
                                            ),
                                          ],
                                        );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: LoaderStyleWidget(),
                  );
                });
          }),
    );
  }

  Widget devider() {
    return Column(
      children: [
        SizedBox(height: 6.h),
        Container(
            color: AppColors.GREY_TEXT_COLOR,
            width: double.infinity,
            height: 0.3.h),
        SizedBox(height: 10.h),
      ],
    );
  }
}
