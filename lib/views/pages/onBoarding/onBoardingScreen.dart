import 'package:bnaa/views/widgets/buttons/normalButtonwithIcon.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/normalButtonWithIconModel.model.dart';
import '../auth/authScreen.dart';

class FirstOnScreen extends StatefulWidget {
  const FirstOnScreen({Key? key}) : super(key: key);

  @override
  _FirstOnScreenState createState() => _FirstOnScreenState();
}

class _FirstOnScreenState extends State<FirstOnScreen> {
  PageController controller = PageController();
  int _totalDots = 2;
  double _currentPosition = 0.0;

  double _validPosition(double position) {
    if (position >= _totalDots) return 0;
    if (position < 0) return _totalDots - 1.0;
    return position;
  }

  void _updatePosition(int position) {
    setState(() => _currentPosition = _validPosition(position.toDouble()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(19, 46, 63, 1),
      body: Stack(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Text('Logo',
                    style: TextStyle(fontSize: 18.sp, color: Colors.white)),
              )),
          PageView(
              controller: controller,
              onPageChanged: _updatePosition,
              children: [
                OnboardingScreen(
                  1,
                  SvgPicture.asset("assets/icons/architecht1.svg"),
                  'Bienvenue sur bnaa'.tr,
                  //todo implement description
                  "short Description",
                ),
                OnboardingScreen(
                  2,
                  SvgPicture.asset("assets/icons/architect2.svg"),
                  //todo : implement text and description
                  "",
                  "",
                ),
              ]),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    NormalButtonWithIcon(
                      model: NormalButtonWithIconModel(
                        textFontSize: 16.sp,
                        colorText: Colors.white,
                        icon: 'assets/icons/rightArrow.svg',
                        colorButton: Color.fromRGBO(234, 199, 71, 1),
                        width: 120.w,
                        onTap: () {
                          if (_currentPosition == 0) {
                            controller.animateToPage(1,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease);
                          } else {
                            Get.to(AuthScreen());
                          }
                        },
                        height: 52.h,
                        radius: 10.r,
                        text: _currentPosition == 0 ? 'Suivant'.tr : 'Connecter'.tr,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DotsIndicator(
                          dotsCount: 2,
                          decorator: DotsDecorator(
                              activeSize: Size(9.sp, 9.sp),
                              size: Size(9.sp, 9.sp),
                              color: Color.fromRGBO(234, 199, 71, 0.5),
                              activeColor: Color.fromRGBO(234, 199, 71, 1)),
                          position: _currentPosition,
                          onTap: (double page) {
                            setState(() {
                              controller.animateToPage(page.toInt(),
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  final Widget? image;
  final String title1;
  final String title2;
  final int pageNumber;

  const OnboardingScreen(this.pageNumber, this.image, this.title1, this.title2,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.tealAccent.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image!,
          SizedBox(height: 50.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Text(title1,
                    textAlign: TextAlign.center,
                    style: this.pageNumber == 1
                        ? GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            color: Colors.white,
                          )
                        : GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: Colors.white,
                          )),
                SizedBox(height: 24.h)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              title2.toString(),
              textAlign: TextAlign.center,
              style: this.pageNumber == 1
                  ? GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: Colors.white,
                    )
                  : GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
