import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/models/faq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';

class FaqCard extends StatefulWidget {
  Faq model;
  int index;
  FaqCard({required this.model, required this.index});

  @override
  State<FaqCard> createState() => _FaqCardState();
}

class _FaqCardState extends State<FaqCard> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        show = !show;
        setState(() {});
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Container(
          width: 346.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 26.sp,
                      width: 26.sp,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(225, 215, 71, 1)),
                      child: Text('${widget.index + 1}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'Question ${widget.index + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 0.8.sw,
                      child: Text(widget.model.questionFr.toString(),
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.BLUE_COLOR)),
                    ),
                    !show
                        ? SvgPicture.asset(
                            'assets/icons/upIcon.svg',
                            height: 10.sp,
                            width: 10.sp,
                          )
                        : SvgPicture.asset(
                            'assets/icons/dowvIcon.svg',
                            height: 10.sp,
                            width: 10.sp,
                          ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                show
                    ? Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.sp),
                            child: Html(
                              data: widget.model.reponseFr,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r)),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                        ],
                      )
                    : Container(),
                Container(
                  width: double.infinity,
                  height: 2.h,
                  color: AppColors.INACTIVE_GREY_COLOR,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
