import 'package:bnaa/models/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../widgets/image_holder.dart';

class CarouselClientDetailsProduct extends StatefulWidget {
  List<ProductImage>? sliderModel;

  CarouselClientDetailsProduct({required this.sliderModel});

  @override
  State<CarouselClientDetailsProduct> createState() =>
      _CarouselClientDetailsProductState();
}

class _CarouselClientDetailsProductState
    extends State<CarouselClientDetailsProduct> {
  final CarouselController _controller = CarouselController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.sliderModel!.isNotEmpty) {
      return Container(
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            widget.sliderModel!.length > 1
                ? Positioned(
                    left: 20.w,
                    child: InkWell(
                      onTap: () {
                        _controller.previousPage();
                        setState(() {});
                      },
                      child: SvgPicture.asset('assets/icons/previousIcon.svg'),
                    ),
                  )
                : Container(),
            CarouselSlider.builder(
                itemCount:  widget.sliderModel!.length,
                itemBuilder: (context, index, index2) {
                  Widget image = CachedNetworkImage(
                    errorWidget: (ctx, _, __) => imageHolder,
                    imageUrl: widget.sliderModel![index].link,
                    fit: BoxFit.contain,
                  );
                  _controller.stopAutoPlay();
                  return InkWell(
                    onTap: () => Get.to(
                        () => HeroPage(tag: 'image$index', image: image)),
                    child: Hero(
                      tag: "image$index",
                      child: image,
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
            widget.sliderModel!.length > 1
                ? Positioned(
                    right: 20.w,
                    child: InkWell(
                        onTap: () {
                          _controller.nextPage();
                          setState(() {});
                        },
                        child: SvgPicture.asset('assets/icons/nextIcon2.svg')))
                : Container(),
            Positioned(
              bottom: 8.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.sliderModel!.map((entry) {
                  return GestureDetector(
                      onTap: () => _controller
                          .animateToPage(widget.sliderModel!.indexOf(entry)),
                      child: Container(
                        width: 9.sp,
                        height: 9.sp,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 5.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: entry ==
                                  widget.sliderModel![currentPage].toString()
                              ? const Color.fromRGBO(52, 103, 128, 1)
                              : const Color.fromRGBO(52, 103, 128, 0.5),
                        ),
                      ));
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }
    return InkWell(
      onTap: () =>
          Get.to(() => HeroPage(tag: 'image_holder', image: imageHolder)),
      child: Hero(
        tag: "image_holder",
        child: imageHolder,
      ),
    );
  }
}

class HeroPage extends StatelessWidget {
  var tag;
  Widget image;

  HeroPage({required this.tag, required this.image});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        child: Stack(
          children: [
            Positioned.fill(child: Container(color: Colors.black)),
            Center(child: image),
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              child: InkWell(
                onTap: () => Get.back(),
                child: const Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
