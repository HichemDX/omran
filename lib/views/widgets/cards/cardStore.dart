import 'package:bnaa/views/client_view/client_store_details_page/client_store_details_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../models/store.dart';
import '../image_holder.dart';

class CardStore extends StatelessWidget {
  Store model;

  CardStore({required this.model});

  @override
Widget build(BuildContext context) {
  return SizedBox(
    height: 190.h, // Set a fixed height for the card
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: InkWell(
        onTap: () {
          Get.to(ClientStoreDetailsPage(
            store: model,
          ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 4,
                offset: Offset(0, 2), // Shadow position
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(height: 10.h),
             AspectRatio(
            aspectRatio: 2,
            child: Container(
              decoration: BoxDecoration(),
              child: model.image.toString() ==
                      'https://omran-dz.com/icons/store.png'
                  ? Image.asset(
                      'assets/icons/profilestore3.png',
                    )
                  : CachedNetworkImage(
                      errorWidget: (ctx, _, __) => imageHolder,
                      imageUrl: model.image.toString(),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
              Container(height: 0.4.sp, width: double.infinity, color: Colors.grey),
              SizedBox(height: 10.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 5.w),
                    child: Container(
                      child: Text(
                        model.name.toString(),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 5.w),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/locationIcon.svg',
                          height: 10.sp,
                          width: 10.sp,
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Text(
                            model.addres.toString(),
                            style: TextStyle(fontSize: 12.sp, color: Colors.black),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            
            ],
          ),
        ),
      ),
    ),
  );
}
}


