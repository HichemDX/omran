import 'package:bnaa/models/slider.dart';
import 'package:bnaa/views/widgets/carousel/carouselHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SliderWidget extends StatelessWidget {
  const SliderWidget({Key? key}) : super(key: key);

  static List<HomeSlider> homeSlider = [
    HomeSlider(
        id: 1,
        link:
        'https://www.incimages.com/uploaded_files/image/1920x1080/getty_509107562_2000133320009280346_351827.jpg'),
    HomeSlider(
        id: 2,
        link:
        'https://i.pinimg.com/originals/30/5c/5a/305c5a457807ba421ed67495c93198d3.jpg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: CarouselHome(
        sliderModel: homeSlider,
      ),
    );
  }
}
