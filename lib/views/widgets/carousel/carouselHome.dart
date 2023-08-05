import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/slider.dart';
import '../image_holder.dart';

class CarouselHome extends StatefulWidget {
  List<HomeSlider> sliderModel;

  CarouselHome({required this.sliderModel});

  @override
  State<CarouselHome> createState() => _CarouselHomeState();
}

class _CarouselHomeState extends State<CarouselHome> {
  final CarouselController _controller = CarouselController();
  int currentPage = 2;

  Future<void> _launchInBrowser(String link) async {
    if (! await launchUrl(
      Uri.parse(link),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $link');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CarouselSlider.builder(
              itemCount: widget.sliderModel.length,
              itemBuilder: (context, index, index2) {
                return InkWell(
                  key: Key(widget.sliderModel[index].id.toString()),
                  onTap: () {
                    _launchInBrowser("${widget.sliderModel[index].link}");
                  },
                  child: Container(
                    height: 120.h,
                    width: 1.sw,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: CachedNetworkImage(
                        errorWidget: (ctx, _, __) => imageHolder,
                        imageUrl: widget.sliderModel[index].image.toString(),
                        fit: BoxFit.cover,
                      ),
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
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              )),
          Positioned(
            bottom: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: widget.sliderModel.map((entry) {
                return GestureDetector(
                    onTap: () => _controller
                        .animateToPage(widget.sliderModel.indexOf(entry)),
                    child: Container(
                      width: widget.sliderModel.indexOf(entry) == currentPage
                          ? 20.0.w
                          : 10.w,
                      height: 5.0.h,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                      decoration: BoxDecoration(
                        borderRadius:
                            widget.sliderModel.indexOf(entry) == currentPage
                                ? BorderRadius.circular(4.r)
                                : null,
                        shape: widget.sliderModel.indexOf(entry) != currentPage
                            ? BoxShape.circle
                            : BoxShape.rectangle,
                        color: widget.sliderModel.indexOf(entry) == currentPage
                            ? AppColors.ORANGE_COLOR
                            : Colors.white,
                      ),
                    ));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
