import 'package:bnaa/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../models/listCommandCommand.model.dart';
import '../../../widgets/image_holder.dart';

class ListProductCommandCard extends StatelessWidget {
  ListCommandModel model;
  ListProductCommandCard({required this.model});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: AppColors.BLUE_COLOR,
            blurRadius: 1,
            offset: Offset(0, 10), // Shadow position
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Container(
                        height: 25.sp,
                        width: 25.sp,
                        child: CachedNetworkImage(
                          errorWidget: (ctx, _, __) => imageHolder,
                          fit: BoxFit.cover, // OR BoxFit.fitWidth
                          alignment: FractionalOffset.topCenter,
                          imageUrl: model.storeLogo.toString(),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: EdgeInsets.only(left: 1.sp),
                        child: Container(
                          child: Text(model.storeName.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 18.sp)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: SvgPicture.asset(
                            'assets/icons/remove.svg',
                            height: 18.sp,
                            width: 18.sp,
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
            height: 35.h,
          ),
          SizedBox(height: 35.h),
          ListView.builder(
              shrinkWrap: true,
              itemCount: model.listProducts!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(244, 242, 242, 1),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/remove.svg',
                                    height: 17.sp,
                                    width: 17.sp,
                                  ),
                                  SizedBox(width: 10.w),
                                  Container(
                                    constraints: BoxConstraints(
                                        minHeight: 30.h,
                                        minWidth: 210.w,
                                        maxHeight: 30.h,
                                        maxWidth: 210.w),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                              model.listProducts![index].name
                                                  .toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black)),
                                        ),
                                        Text(
                                            model.listProducts![index].price
                                                    .toString() +
                                                " DA /" +
                                                model
                                                    .listProducts![index].unitFr
                                                    .toString(),
                                            textAlign: TextAlign.start,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w300,
                                                color: AppColors
                                                    .GREY_TEXT_COLOR)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SvgPicture.asset(
                                      'assets/icons/plusIcons.svg'),
                                  SizedBox(width: 5.w),
                                  Text(
                                      model.listProducts![index].qty.toString(),
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                  SizedBox(width: 5.w),
                                  SvgPicture.asset(
                                      'assets/icons/minusIcons.svg'),
                                ],
                              ),
                            )
                          ]),
                    ),
                  ),
                );
              }),
          SizedBox(height: 10.h),
          Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(244, 242, 242, 1),
                borderRadius: BorderRadius.circular(5.r)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('A payer',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16.sp)),
                    Text('1500 DA',
                        style: TextStyle(
                            color: AppColors.GREY_TEXT_COLOR,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp))
                  ]),
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(207, 41, 41, 1),
                borderRadius: BorderRadius.circular(5.r)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('delivery'.tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp)),
                    Text(
                        model.delivery == true
                            ? 'non disponible'
                            : 'disponible',
                        style: TextStyle(
                            color: Color.fromRGBO(249, 227, 227, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp))
                  ]),
            ),
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Total : ',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  )),
              Text('1 5500 Da',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ))
            ],
          )
        ]),
      ),
    );
  }
}
