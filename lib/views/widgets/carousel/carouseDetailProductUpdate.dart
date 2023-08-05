import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../image_holder.dart';

class CarouselDetailsUpdateProduct extends StatefulWidget {
  List<String>? sliderModel;
  CarouselDetailsUpdateProduct({required this.sliderModel});
  @override
  State<CarouselDetailsUpdateProduct> createState() =>
      _CarouselDetailsUpdateProductState();
}

class _CarouselDetailsUpdateProductState
    extends State<CarouselDetailsUpdateProduct> {
  final CarouselController _controller = CarouselController();
  int currentPage = 2;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.1),
      height: 330.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              left: 20.w,
              child: InkWell(
                  onTap: () {
                    _controller.previousPage();
                    setState(() {});
                  },
                  child: SvgPicture.asset('assets/icons/previousIcon.svg'))),
          CarouselSlider.builder(
              itemCount: widget.sliderModel!.length,
              itemBuilder: (context, index, index2) {
                return InkWell(
                  key: Key(widget.sliderModel![index]),
                  onTap: () {
                    //   showUrl(AppImages.dummyImages[index].link.toString());
                  },
                  child: Container(
                    height: 120.h,
                    width: 0.7.sw,
                    child: CachedNetworkImage(
                      errorWidget: (ctx, _, __) => imageHolder,
                      imageUrl: widget.sliderModel![index].toString(),
                      fit: BoxFit.cover,
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
              right: 20.w,
              child: InkWell(
                  onTap: () {
                    _controller.nextPage();
                    setState(() {});
                  },
                  child: SvgPicture.asset('assets/icons/nextIcon2.svg'))),
          Positioned(
            bottom: 20.w,
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
                      margin:
                          EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            entry == widget.sliderModel![currentPage].toString()
                                ? Color.fromRGBO(52, 103, 128, 1)
                                : Color.fromRGBO(52, 103, 128, 0.5),
                      ),
                    ));
              }).toList(),
            ),
          ),
          SvgPicture.asset('assets/icons/imageCarouselIcon.svg')
        ],
      ),
    );
  }
}
