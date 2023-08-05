
import 'package:bnaa/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/client_controllers/home_controller.dart';
import '../../../models/category.dart';
import '../../client_view/client_home_page/components/client_all_category_products.dart';
import '../image_holder.dart';

class CardCategory extends StatelessWidget {
  final homeController = Get.put(HomeController());
  final Category model;

  CardCategory({required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        /*List<Product> products = [];
        try {
          products = homeController.homeViewModel!.productsByCategories
              .firstWhere((element) => element.category.id == model.id)
              .products;
        } catch (error) {
          print(error);
        }*/
        print(model.id);
        Get.to(
          ClientAllCategoryProducts(
            categoryId: model.id ?? 109,
          ),
        );
      },
      child: Card(
        elevation: 3,
        child: Container(
          height: 50.sp,
          padding: EdgeInsets.all(10.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CachedNetworkImage(
                errorWidget: (ctx, _, __) => imageHolder,
                imageUrl: model.icon!,
                // height: ,
                width:50.w,
              ),
              SizedBox(width: 5.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 5),
                child: Text(
                  Get.locale?.languageCode == 'fr'
                      ? model.nameFr.toString()
                      : model.nameAr.toString(),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.BLUE_COLOR,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 4,
                offset: const Offset(0, 2), // Shadow position
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CardCategory2 extends StatelessWidget {
  final homeController = Get.put(HomeController());
  final Category model;

  CardCategory2({required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        /*List<Product> products = [];
        try {
          products = homeController.homeViewModel!.productsByCategories
              .firstWhere((element) => element.category.id == model.id)
              .products;
        } catch (error) {
          print(error);
        }*/
        print(model.id);
        Get.to(
          ClientAllCategoryProducts(
            categoryId: model.id ?? 109,
          ),
        );
      },
      child: Card(
        elevation: 3,
        child: Container(
          height: 50.sp,
          padding: EdgeInsets.all(10.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(

                child: CachedNetworkImage(
                  errorWidget: (ctx, _, __) => imageHolder,
                  imageUrl: model.icon!,
                  // height: ,
                  width:100.w,
                ),
              ),
              SizedBox(width: 10.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 5),
                child: Text(
                  Get.locale?.languageCode == 'fr'
                      ? model.nameFr.toString()
                      : model.nameAr.toString(),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.BLUE_COLOR,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 4,
                offset: const Offset(0, 2), // Shadow position
              ),
            ],
          ),
        ),
      ),
    );
  }
}


















// class CardCategory extends StatelessWidget {
//   final homeController = Get.put(HomeController());
//   final Category model;
//   CardCategory({Key? key, required this.model}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Get.to(
//           ClientAllCategoryProducts(
//             categoryId: model.id ?? 109,
//           ),
//         );
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 5.w),
//         width: 50.w,
//         height: 30.h,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8.r),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.shade300,
//               blurRadius: 4,
//               offset: const Offset(0, 2), // Shadow position
//             ),
//           ],
//         ),
//         child: Card(
//             elevation: 3,
//             child: Padding(
//                 padding: EdgeInsets.all(8),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(2.w),
//                       color: Colors.white,
//                       child: CachedNetworkImage(
//                         errorWidget: (ctx, _, __) => imageHolder,
//                         imageUrl: model.icon!,
//                         height: 60.sp,
//                         width: double.infinity,
//                       ),
//                     ),
//                     Text(
//                       Get.locale?.languageCode == 'fr'
//                           ? model.nameFr.toString()
//                           : model.nameAr.toString(),
//                       maxLines: 1,
//                       textAlign: TextAlign.center,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         color: AppColors.BLUE_COLOR,
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w300,
//                       ),
//                     ),
//                   ],
//                 ))),
//       ),
//     );
//   }
// }
