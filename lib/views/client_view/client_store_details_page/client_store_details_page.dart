import 'package:bnaa/controllers/client_controllers/store_details_controller.dart';
import 'package:bnaa/models/store.dart';
import 'package:bnaa/views/client_view/client_store_details_page/compenents/categories_paging_widget.dart';
import 'package:bnaa/views/client_view/reportStor/reportStor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../widgets/appBar/appBar.dart';
import '../../widgets/image_holder.dart';

class ClientStoreDetailsPage extends StatefulWidget {
  Store store;

  ClientStoreDetailsPage({required this.store});

  @override
  State<ClientStoreDetailsPage> createState() => _ClientStoreDetailsPageState();
}

class _ClientStoreDetailsPageState extends State<ClientStoreDetailsPage> {
  final storeDetailsController = Get.put(StoreController());

  @override
  void initState() {
    super.initState();
    storeDetailsController.selectStore(widget.store);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          title: 'store details'.tr,
          icon: 'assets/icons/return.svg',
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 100.sp,
                        width: 100.sp,
                        child: 
                          widget.store.image! ==
                                  'https://omran-dz.com/icons/store.png'
                              ? Image.asset(
                                  'assets/icons/profilestore3.png',
                                  fit: BoxFit.cover,
                                  height: 100.sp,
                                  width: 100.sp,
                                )
                        
                        
                      :  CachedNetworkImage(
                          errorWidget: (ctx, _, __) => imageHolder,
                          imageUrl: widget.store.image!,
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
                              widget.store.name!,
                              style: TextStyle(
                                color: AppColors.BLACK_TEXT_COLOR,
                                fontSize: 26.sp,
                                fontWeight: FontWeight.bold,
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
                                Text("+213 ${widget.store.phone!}",
                                    style: TextStyle(fontSize: 14.sp))
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
                                Text(
                                  Get.deviceLocale?.languageCode == 'fr'
                                      ? "${widget.store.wilaya!.nameFr!} , ${widget.store.commune!.nameFr!}"
                                      : "${widget.store.wilaya!.nameAr!} , ${widget.store.commune!.nameAr!}",
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
                                  color: Colors.transparent,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Text("${widget.store.addres}",
                                      style: TextStyle(fontSize: 14.sp)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(ReportStor(store: widget.store));
                        },
                        child: Icon(
                          Icons.report,
                          size: 35,
                          color: Colors.orange,
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
                  SizedBox(height: 18.54.h),
                  const CategoriesPagingWidget(),
                  SizedBox(height: 18.54.h),
                  /*Expanded(
              child: GetBuilder<StoreController>(builder: (_) {
                if (storeDetailsController.isLoading) {
                  return Center(
                    child: LoaderStyleWidget(),
                  );
                }
                return DynamicHeightGridView(
                  controller: scrollController,
                  shrinkWrap: true,
                  builder: (ctx, index) {
                    if(index < storeDetailsController.products.length){
                      return CardProduct(
                          product:
                          storeDetailsController.products[index]);
                    }else if(storeDetailsController.canLoadMore){
                      return Center(child: LoaderStyleWidget(),);
                    }else return Container();
                  },
                  itemCount: storeDetailsController.products.length + 1,
                  crossAxisCount: 2,
                );
              }),
          )*/
                ],
              ),
            ),
          ),
        ));
  }
}
