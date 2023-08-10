import 'package:bnaa/controllers/favorite_product_controller.dart';
import 'package:bnaa/views/client_view/product_details_page/product_details_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/client_controllers/home_controller.dart';
import '../../../models/product.dart';
import '../image_holder.dart';

// class CardProduct extends StatefulWidget {
//   Product product;

//   CardProduct({required this.product});

//   @override
//   State<CardProduct> createState() => _CardProductState();
// }

// class _CardProductState extends State<CardProduct> {
//   final favoriteController = Get.put(FavoriteProductController());
//   final homeController = Get.put(HomeController());

//   _addToFavorite() async {
//     widget.product.save = true;
//     setState(() {});
//     await favoriteController.addToFavorite(widget.product).then((response) {
//       if (!response) {
//         widget.product.save = false;
//         setState(() {});
//         Fluttertoast.showToast(msg: "Erreur s'est produite".tr);
//       } else {
//         Fluttertoast.showToast(msg: "Added successfully".tr);
//       }
//     });
//   }

//   _deleteFromFavorite() {
//     widget.product.save = false;

//     setState(() {});
//     homeController.homeViewModel!.productsByCategories
//         .firstWhere(
//             (element) => element.category.id == widget.product.categoryId)
//         .products
//         .firstWhere((element) => element.id == widget.product.id)
//         .save = false;
//     homeController.update();
//     favoriteController.removeFromFavorite(widget.product).then(
//       (response) {
//         if (!response) {
//           widget.product.save = true;
//           setState(() {});
//           homeController.homeViewModel!.productsByCategories
//               .firstWhere(
//                   (element) => element.category.id == widget.product.categoryId)
//               .products
//               .firstWhere((element) => element.id == widget.product.id)
//               .save = true;
//           homeController.update();
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: InkWell(
//         onTap: () {
//           Get.to(
//             () => ProductDetailsPage(
//               type: true,
//               product: widget.product,
//             ),
//           );
//         },
//         child: Container(
//           width: MediaQuery.of(context).size.width * 0.4,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8.r),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.shade300,
//                 blurRadius: 4,
//                 offset: const Offset(0, 2), // Shadow position
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(8.r),
//                     topRight: Radius.circular(8.r),
//                   ),
//                   color: AppColors.BLUE_COLOR2,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: Row(
//                     children: [
//                       CachedNetworkImage(
//                         errorWidget: (ctx, _, __) => imageHolder,
//                         imageUrl: widget.product.storeImage.toString(),
//                         fit: BoxFit.fill,
//                         height: 25.sp,
//                         width: 25.sp,
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: Text(widget.product.storeName.toString(),
//                             maxLines: 1,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 fontSize: 10.sp)),
//                       ),
//                       widget.product.save == false
//                           ? InkWell(
//                               onTap: _addToFavorite,
//                               child: Padding(
//                                 padding: EdgeInsets.only(left: 5.w),
//                                 child: SvgPicture.asset(
//                                   'assets/icons/saveIcon.svg',
//                                   height: 24.sp,
//                                   width: 24.sp,
//                                 ),
//                               ),
//                             )
//                           : InkWell(
//                               onTap: _deleteFromFavorite,
//                               child: Padding(
//                                 padding: EdgeInsets.only(left: 5.w),
//                                 child: SvgPicture.asset(
//                                   'assets/icons/saveIcon2.svg',
//                                   height: 24.sp,
//                                   width: 24.sp,
//                                 ),
//                               ),
//                             ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 140,
//                 height: 80,
//                 child: CachedNetworkImage(
//                   errorWidget: (ctx, _, __) => imageHolder,
//                   imageUrl: widget.product.productImage.toString(),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Container(
//                 height: 1.sp,
//                 width: double.infinity,
//                 color: Colors.grey,
//               ),
//               SizedBox(height: 12.h),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 5.sp),
//                     child: Text(
//                       widget.product.name.toString(),
//                       textAlign: TextAlign.start,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 13.h),
//                   Padding(
//                     padding: EdgeInsetsDirectional.only(start: 10.sp),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         SvgPicture.asset(
//                           'assets/icons/locationIcon.svg',
//                           height: 13.sp,
//                           width: 13.sp,
//                         ),
//                         SizedBox(width: 5.w),
//                         Expanded(
//                           child: Text(
//                             widget.product.address.toString(),
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                             style: TextStyle(
//                               fontSize: 10.sp,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 5.h),
//                   Padding(
//                     padding: EdgeInsetsDirectional.only(start: 10.sp),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         SvgPicture.asset(
//                           'assets/icons/moneyIcon.svg',
//                           height: 13.sp,
//                           width: 13.sp,
//                         ),
//                         SizedBox(width: 5.w),
//                         Expanded(
//                           child: RichText(
//                             overflow: TextOverflow.ellipsis,
//                             text: TextSpan(
//                               text:
//                                   '${int.parse(widget.product.price!).toStringAsFixed(0).toString()} ' +
//                                       'da'.tr,
//                               style: GoogleFonts.montserrat(
//                                   fontSize: 9.sp, color: Colors.black),
//                               children: [
//                                 TextSpan(
//                                   text: "/ " +
//                                       (Get.locale?.languageCode == 'fr'
//                                           ? widget.product.unitFr.toString()
//                                           : widget.product.unitAr.toString()),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10.h),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class CardProduct extends StatefulWidget {
   Product product;
   final bool favorite;
  CardProduct({required this.product, this.favorite  = false});

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  final favoriteController = Get.put(FavoriteProductController());
  final homeController = Get.put(HomeController());

  _addToFavorite() async {
    widget.product.save = true;
    setState(() {});
    await favoriteController.addToFavorite(widget.product).then((response) {
      if (!response) {
        widget.product.save = false;
        setState(() {});
        Fluttertoast.showToast(msg: "Erreur s'est produite".tr);
      } else {
        Fluttertoast.showToast(msg: "Added successfully".tr);
      }
    });
  }

  _deleteFromFavorite() {
    widget.product.save = false;

    setState(() {});
    homeController.homeViewModel!.productsByCategories
        .firstWhere(
            (element) => element.category.id == widget.product.categoryId)
        .products
        .firstWhere((element) => element.id == widget.product.id)
        .save = false;
    homeController.update();
    favoriteController.removeFromFavorite(widget.product).then(
      (response) {
        if (!response) {
          widget.product.save = true;
          setState(() {});
          homeController.homeViewModel!.productsByCategories
              .firstWhere(
                  (element) => element.category.id == widget.product.categoryId)
              .products
              .firstWhere((element) => element.id == widget.product.id)
              .save = true;
          homeController.update();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Get.to(
            () => ProductDetailsPage(
              type: true,
              product: widget.product,
            ),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 4,
                offset: const Offset(0, 2), // Shadow position
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                decoration: BoxDecoration(
                    color: widget.favorite? Color.fromARGB(255, 228, 117, 20) :Color(0xff346780) ,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14.r),
                      topRight: Radius.circular(14.r),
                    )),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: Colors.white),
                          child: 
                            widget.product.storeImage! ==
                                  'https://omran-dz.com/icons/store.png'
                              ? Image.asset(
                                  'assets/icons/profilestore3.png',
                                  fit: BoxFit.cover,
                                  height: 24.sp,
                                  width: 24.sp,
                                  
                                )
                          
                          
                          
                        :  CachedNetworkImage(
                            errorWidget: (ctx, _, __) => imageHolder,


                            
                            imageUrl: widget.product.storeImage.toString(),
                            fit: BoxFit.fill,
                            height: 24.sp,
                            width: 24.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Expanded(
                        child: Text(widget.product.storeName.toString(),
                              maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                
                                color: Colors.white,
                                fontSize: 14.sp)),
                      ),
                    ]),
              ),
              Expanded(
                child: Container(
                  
                  width: double.infinity,
                  child: CachedNetworkImage(
                    errorWidget: (ctx, _, __) => imageHolder,
                    imageUrl: widget.product.productImage.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                child: Column(  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.name.toString(),
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                widget.product.address.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Color.fromARGB(255, 79, 79, 79),
                                ),
                              ),
                            ],
                          ),
                        ),
                        widget.product.save == false
                            ? InkWell(
                                onTap: _addToFavorite,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: SvgPicture.asset(
                                    'assets/icons/saveIcon.svg',
                                    height: 24.sp,
                                    width: 24.sp,
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: _deleteFromFavorite,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: SvgPicture.asset(
                                    'assets/icons/saveIcon2.svg',
                                    height: 24.sp,
                                    width: 24.sp,
                                  ),
                                ),
                              ),
                      ],
                    ),
                    SizedBox(height: 14.sp),
                    Align( alignment: Alignment.centerRight,
                    
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text:
                              '${int.parse(widget.product.price!).toStringAsFixed(0).toString()} ' +
                                  'da'.tr,
                          style: GoogleFonts.montserrat(
                              fontSize: 15.sp, color: Color.fromARGB(255, 212, 20, 20),
                              fontWeight: FontWeight.bold),
                              
                          children: [
                            TextSpan(
                              text: "/ " +
                                  (Get.locale?.languageCode == 'fr'
                                      ? widget.product.unitFr.toString()
                                      : widget.product.unitAr.toString()),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
