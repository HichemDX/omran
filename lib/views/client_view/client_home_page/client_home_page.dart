import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/controllers/cart_controller.dart';
import 'package:bnaa/controllers/client_controllers/home_controller.dart';
import 'package:bnaa/views/client_view/client_all_categories_page/client_all_categories_page.dart';
import 'package:bnaa/views/client_view/client_home_page/components/catigories_widget.dart';
import 'package:bnaa/views/client_view/client_home_page/components/products_widget.dart';
import 'package:bnaa/views/client_view/search_page/search_page.dart';
import 'package:bnaa/views/widgets/appBar/appBarHome.dart';
import 'package:bnaa/views/widgets/carousel/carouselHome.dart';
import 'package:bnaa/views/widgets/line/line.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ClientHomePage extends StatelessWidget {
  final homeController = Get.put(HomeController());
  final cartController = Get.put(CartController());

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHomeWidget(
        title: 'home'.tr,
        scaffoldKey: scaffoldKey,
      ),
      body: SafeArea(
        child: FutureBuilder<bool>(
          future: homeController.initHomeController(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*const SizedBox(height: 12),
                    InputSearch(enabled: true),*/
                    const SizedBox(height: 12),
                    if (homeController.homeViewModel!.homeSlider.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: CarouselHome(
                          sliderModel: homeController.homeViewModel!.homeSlider,
                        ),
                      ),
                    SizedBox(height: 15.h),
                    InkWell(
                      onTap: () {
                        Get.to(ClientAllCategoriesPage());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Line(
                          title1: 'categories'.tr.tr,
                          title2: 'more'.tr,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    CategoriesWidget(
                      categories: homeController.homeViewModel!.categories,
                      productHomeModel:
                          homeController.homeViewModel!.productsByCategories,
                    ),
                    SizedBox(height: 15.h),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: homeController
                          .homeViewModel!.productsByCategories.length,
                      itemBuilder: (context, index) {
                        return ProductsWidget(
                          productHomeModel: homeController
                              .homeViewModel!.productsByCategories[index],
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return Center(child: LoaderStyleWidget());
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: InkWell(
        onTap: () async {
          Get.to(() => SearchPage());
         /* SharedPreferences storage = await SharedPreferences.getInstance();
          String? token = storage.getString('device_id');

          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: SelectableText(
                token ?? "",
              ),
            ),
          );*/

          /* SharedPreferences storage = await SharedPreferences.getInstance();
          final String? fcm = storage.getString('device_id');
          print(fcm);
          final dio = Dio();
          try {
            await dio.post(
              'https://fcm.googleapis.com/fcm/send',
              options: Options(
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization':
                      'key=AAAAvfoYJg0:APA91bF2Da3Sdo_if25beLoM7K5qOA_wK77VJ10heViuic48N3xYxHfBszMLKezEPZILpQC-8sVwFBC1DrfdGOtdn5fkhyokIb2FJDBPXrL4iS80AGFUyZRV5eubWP2NBSu3a9t-I8kP',
                },
              ),
              data: {
                'priority': 'high',
                'data': {
                  'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                  'status': 'done',
                  'body': 'TEST',
                  'title': 'test yakho hada makan',
                },
                'notification': {
                  'body': 'TEST',
                  'title': 'test yakho hada makan',
                  'android_channel_id': 'dbbnaa',
                },
                'to': fcm,
              },
            );
          } catch (error) {
            print(error);
          }*/
        },
        child: Container(
          height: 54.sp,
          width: 54.sp,
          child: Container(
            padding: EdgeInsets.all(11.sp),
            child: const Icon(Icons.search, color: Colors.white)
            /*SvgPicture.asset(
              'assets/icons/locationIconHome.svg',
              height: 12.sp,
              width: 12.sp,
            )*/
            ,
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 4,
                offset: const Offset(0, 2), // Shadow position
              ),
            ],
            shape: BoxShape.circle,
            color: AppColors.ORANGE_COLOR,
          ),
        ),
      ),
    );
  }
}
