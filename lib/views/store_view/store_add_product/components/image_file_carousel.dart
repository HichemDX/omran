import 'dart:io';

import 'package:bnaa/models/image.dart';
import 'package:bnaa/utils/custom_gallery.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

class ImageFilesCarousel extends StatefulWidget {

  List listImages;
  Function(int)? deletedImage;
  ImageFilesCarousel(
      {required this.listImages,  this.deletedImage});

  @override
  State<ImageFilesCarousel> createState() => _ImageFilesCarouselState();
}

class _ImageFilesCarouselState extends State<ImageFilesCarousel> {
  final CarouselController _controller = CarouselController();
  int currentPage = 0;



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 330.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CarouselSlider.builder(

              itemCount: widget.listImages.length,
              itemBuilder: (context, index, index2) {
                return GestureDetector(
                  onTap: () {
                    Get.to(Gallery(
                      listImages: widget.listImages,
                      index: index,
                      deletedImage: widget.deletedImage,
                    ));
                  },
                  child: Container(
                    height: 330.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: widget.listImages[index] is File
                          ? DecorationImage(
                              image: FileImage(widget.listImages[index]),
                              fit: BoxFit.fitHeight,
                            )
                          : DecorationImage(
                              image: NetworkImage((widget.listImages[index] as ProductImage ).link),
                              fit: BoxFit.fitHeight,
                            ),
                    ),
                  ),
                );
              },
              carouselController: _controller,
              options: CarouselOptions(
                pauseAutoPlayInFiniteScroll: true,
                onPageChanged: (val, _) {
                  setState(() {
                    currentPage = val;
                    _controller.jumpToPage(val);
                  });
                },
                height: 182,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              )),
          Positioned(
            bottom: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(widget.listImages.length, (index) {
                return Container(
                  width: 9.sp,
                  height: 9.sp,
                  margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
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
}
