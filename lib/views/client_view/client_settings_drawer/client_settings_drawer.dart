import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/auth/auth_controller.dart';
import 'package:bnaa/controllers/client_controllers/profile_controller.dart';
import 'package:bnaa/models/user.dart';
import 'package:bnaa/views/client_view/client_edit_profile_page/client_edit_profile_page.dart';
import 'package:bnaa/views/client_view/client_saved_product_page/client_saved_product_page.dart';
import 'package:bnaa/views/pages/change_language_page/change_languages_page.dart';
import 'package:bnaa/views/pages/faq_page/faq_page.dart';
import 'package:bnaa/views/client_view/client_notifications_page/client_notifications_page.dart';
import 'package:bnaa/views/pages/offers/offers_screen.dart';
import 'package:bnaa/views/pages/termes_conditions_page/termes_conditions_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../pages/aboutUs/aboutUsScreen.dart';
import '../../widgets/image_holder.dart';

class ClientSettingsDrawer extends StatelessWidget {
  final profileController = Get.put(ProfileController());
  final AuthProvider authProvider = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User>(
        future: profileController.getUserProfile(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          return GetBuilder<ProfileController>(
            builder: (_) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 25.h,
                  horizontal: 25.w,
                ),
                child: ListView(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100.sp,
                          width: 100.sp,
                          child: profileController.user!.pictureLink ==
                                  'https://omran-dz.com/icons/user.png'
                              ? Image.asset(
                                  'assets/icons/profile2.png',
                                  fit: BoxFit.cover,
                                  height: 100.sp,
                                  width: 100.sp,
                                )
                              : CachedNetworkImage(
                                  imageUrl:
                                      "${profileController.user!.pictureLink}",
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) {
                                    print("Error loading image from URL: $url");
                                    print("Error details: $error");
                                    return imageHolder; // Provide a fallback image or widget when an error occurs.
                                  },
                                ),
                        ),
                        SizedBox(width: 28.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${profileController.user!.name}',
                                style: TextStyle(
                                  color: AppColors.BLACK_TEXT_COLOR,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/phoneIcon.svg',
                                    height: 12.sp,
                                    width: 12.sp,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    '${profileController.user!.phone}',
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/locationIcon.svg',
                                    height: 12.sp,
                                    width: 12.sp,
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(
                                      Get.locale!.languageCode != "fr"
                                          ? '${profileController.user!.wilaya!.nameAr ?? ""}, ${profileController.user!.commune?.nameAr ?? ""}'
                                          : '${profileController.user!.wilaya!.nameFr ?? ""}, ${profileController.user!.commune?.nameFr ?? ""}',
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.54.h),
                    Container(
                      color: AppColors.BLUE_COLOR,
                      width: double.infinity,
                      height: 1.h,
                    ),
                    SizedBox(height: 49.h),
                    InkWell(
                      onTap: () {
                        Get.to(ClientNotificationsPage());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/notifIconList.svg',
                                  width: 17.sp,
                                  height: 17.sp,
                                ),
                                SizedBox(width: 8.w),
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
                        Get.to(ClientSavedProductPage());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset('assets/icons/saveIcon.svg',
                                    color: AppColors.BLUE_COLOR,
                                    width: 17.sp,
                                    height: 17.sp),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  'saved'.tr,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/iIcon.svg',
                                  width: 17.sp,
                                  height: 17.sp,
                                ),
                                SizedBox(width: 8.w),
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
                            const Icon(Icons.arrow_forward_ios, size: 12)
                          ],
                        ),
                      ),
                    ),
                    devider(),
                    InkWell(
                      onTap: () {
                        Get.to(TermAndConditionPage());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/loiIcon.svg',
                                  width: 17.sp,
                                  height: 17.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'term and condition'.tr,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight
                                        .bold, // Add the bold font weight here
                                  ),
                                ),
                              ],
                            ),
                            const Icon(Icons.arrow_forward_ios, size: 12)
                          ],
                        ),
                      ),
                    ),
                    devider(),
                    //SizedBox(height: 35.h),
                    InkWell(
                      onTap: () {
                        Get.to(ClientEditProfilePage());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                /*SvgPicture.asset(
                                  'assets/icons/personIcon.svg',
                                  width: 17.sp,
                                  height: 17.sp,
                                ),*/
                                const Icon(
                                  Icons.local_offer_outlined,
                                  color: AppColors.BLUE_COLOR2,
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
                        foregroundColor: Colors.white, backgroundColor: Colors.red, // Text color
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
                            color: Colors.white, // Add the color property here
                          ),
                          SizedBox(width: 8.w),
                          Text('logout'.tr,
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.white)),
                          SizedBox(width: 8.w),
                        ],
                      ),
                    ),
                    devider(),
                    SizedBox(height: 19.h),
                    FutureBuilder(
                      future: profileController.getAppInfo(),
                      builder: (context, snapshot) {
                        return profileController.appInfo.isEmpty
                            ? Container()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      launchUrl(
                                        Uri.parse(profileController
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
                                        Uri.parse(profileController
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
                                            path: profileController
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
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
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
