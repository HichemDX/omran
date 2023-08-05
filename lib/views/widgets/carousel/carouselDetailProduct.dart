import 'package:bnaa/controllers/store_controllers/store_products_controller.dart';
import 'package:bnaa/models/image.dart';
import 'package:bnaa/views/widgets/loader_style_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../image_holder.dart';

class CarouselDetailsProduct extends StatefulWidget {
  List<ProductImage>? sliderModel;
  CarouselDetailsProduct({required this.sliderModel});
  @override
  State<CarouselDetailsProduct> createState() => _CarouselDetailsProductState();
}

class _CarouselDetailsProductState extends State<CarouselDetailsProduct> {
  final CarouselController _controller = CarouselController();
  int currentPage = 0;

  StoreProductsController productsController = Get.find();

  _deleteImage(imageId) async {
    Loader.show(context, progressIndicator: LoaderStyleWidget());
    productsController.deleteImageProduct(imageId: imageId).then((value) {
      Loader.hide();
    });
  }

  Future<void> _dialogBuilder(BuildContext context, ProductImage image) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            child: CachedNetworkImage(
              errorWidget: (ctx, _, __) => imageHolder,
              imageUrl: image.link,
              fit: BoxFit.cover,
            ),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5.r)),
          ),
          actions: [
            widget.sliderModel!.length > 1
                ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _deleteImage(image.id);
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ))
                : Container()
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.sliderModel!.isNotEmpty) {
      return Container(
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CarouselSlider.builder(
                itemCount: widget.sliderModel!.length,
                itemBuilder: (context, index, index2) {
                  _controller.stopAutoPlay();
                  return InkWell(
                    key: Key(widget.sliderModel![index].link),
                    onTap: () {
                      //   showUrl(AppImages.dummyImages[index].link.toString());
                      _dialogBuilder(context, widget.sliderModel![index]);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        errorWidget: (ctx, _, __) => imageHolder,
                        imageUrl: widget.sliderModel![index].link,
                        fit: BoxFit.contain,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5.r)),
                    ),
                  );
                },
                carouselController: _controller,
                options: CarouselOptions(
                  onPageChanged: (val, _) {
                    setState(() {
                      currentPage = val;
                      _controller.jumpToPage(val);
                    });
                  },
                  height: 182.h,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                )),
            Container(
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentPage != 0
                      ? IconButton(
                          onPressed: () {
                            _controller.previousPage();
                          },
                          icon:
                              SvgPicture.asset('assets/icons/previousIcon.svg'))
                      : Container(),
                  currentPage != widget.sliderModel!.length - 1
                      ? Positioned(
                          right: 20.w,
                          child: IconButton(
                              onPressed: () {
                                _controller.nextPage();
                              },
                              icon: SvgPicture.asset(
                                  'assets/icons/nextIcon2.svg')))
                      : Container(),
                ],
              ),
            ),
            Positioned(
              bottom: 8.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(widget.sliderModel!.length, (index) {
                  return Container(
                    width: 9.sp,
                    height: 9.sp,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentPage == index
                          ? const Color.fromRGBO(52, 103, 128, 1)
                          : const Color.fromARGB(126, 201, 237, 254),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }
    return Container();
  }
}
