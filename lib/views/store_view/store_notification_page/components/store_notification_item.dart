import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../controllers/locale_controller.dart';
import '../../../../models/store_notification.dart';
import '../../../widgets/image_holder.dart';

import 'package:timeago/timeago.dart' as timeago;

class StoreNotificationComponent extends StatelessWidget {
  StoreNotificationModel model;

  StoreNotificationComponent({required this.model});

  final LocaleController localeController = Get.find();

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    return Container(
     // height: 80.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 50.sp,
                    height: 50.sp,
                    child: CachedNetworkImage(
                      errorWidget: (ctx, _, __) => imageHolder,
                      imageUrl: model.customer!.image.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.customer!.name.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.BLACK_TEXT_COLOR,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        SizedBox(
                          //width: 210.w,
                          child: Text(
                            model.nameFr.toString(),
                            //maxLines: 1,
                            //overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.BLACK_TEXT_COLOR,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              timeago
                  .format(DateTime.parse(model.createdAt.toString()),
                  locale: Get.locale.toString())
                  .toString(),
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.GREY_TEXT_COLOR,
                fontSize: 12.sp,
              ),
            ),

          ],
        ),
      ),
      decoration: BoxDecoration(
        color: model.read != "0"
            ? AppColors.BACKGROUND_SEE_NOTIF_GREY_COLOR
            : AppColors.BLUE_COLOR2.withOpacity(0.3),
      ),
    );
  }
}
