import 'package:bnaa/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timelines/timelines.dart';

const kTileHeight = 50.0;
List<String> etat = [
  "PENDING",
  "PROCESSING",
  "PREPARED",
  "DISPATCHED",
  "DELIVERED",
  "CANCELED"
];

final Map<String, String> etats = {
  "PENDING": 'pending',
  "PROCESSING": 'accepted',
  "PREPARED": 'charged',
  "DISPATCHED": 'on the way',
  "DELIVERED": 'delivered',
  "CANCELED": 'canceled'
};
final Map<String, String> canceledStatus = {
  "PENDING": 'pending',
  "CANCELED": 'canceled',
  "PROCESSING": 'accepted',
  "PREPARED": 'charged',
  "DISPATCHED": 'on the way',
  "DELIVERED": 'delivered',
};

class TimelineStatusPage extends StatelessWidget {
  String statusKey;

  TimelineStatusPage({required this.statusKey});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: _Timeline1(
            status: etat.indexWhere((element) => element == statusKey)),
      ),
    );
  }
}

class _Timeline1 extends StatelessWidget {
  int status;

  _Timeline1({required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == 5) {
      status = 1;
      return Timeline.tileBuilder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        theme: TimelineThemeData(
          nodePosition: 0,
          connectorTheme: const ConnectorThemeData(
            thickness: 3.0,
            color: Color(0xffd3d3d3),
          ),
          indicatorTheme: const IndicatorThemeData(
            size: 15.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        builder: TimelineTileBuilder.connected(
          contentsBuilder: (_, index) {
            if (status > index) {
              return Padding(
                padding: EdgeInsetsDirectional.only(start: 10.w),
                child: Text(
                  canceledStatus.entries.elementAt(index).value.tr,
                  style: GoogleFonts.montserrat(
                      fontSize: 12.sp, fontWeight: FontWeight.w700),
                ),
              );
            } else if (status == index) {
              return Padding(
                padding: EdgeInsetsDirectional.only(start: 10.w),
                child: Text(
                  canceledStatus.entries.elementAt(index).value.tr,
                  style: GoogleFonts.montserrat(
                      color: Colors.red,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700),
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsetsDirectional.only(start: 10.w),
                child: Text(
                  canceledStatus.entries.elementAt(index).value.tr,
                  style: GoogleFonts.montserrat(
                      color: const Color.fromRGBO(217, 217, 217, 1),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700),
                ),
              );
            }
          },
          connectorBuilder: (_, index, __) {
            if (status <= index) {
              return const DashedLineConnector(
                  color: AppColors.INACTIVE_GREY_COLOR);
            } else {
              return const DashedLineConnector(
                  color: Color.fromRGBO(40, 167, 69, 1));
            }
          },
          indicatorBuilder: (_, index) {
            if (status > index) {
              return const OutlinedDotIndicator(
                color: Color.fromRGBO(40, 167, 69, 1),
                borderWidth: 2.0,
                backgroundColor: Colors.white,
              );
            } else if (status == index) {
              return const OutlinedDotIndicator(
                color: Colors.red,
                borderWidth: 2.0,
                backgroundColor: Colors.white,
              );
            } else {
              return const OutlinedDotIndicator(
                color: Color(0xffbabdc0),
                backgroundColor: Colors.white,
              );
            }
          },
          itemExtentBuilder: (_, __) => kTileHeight,
          itemCount: 5,
        ),
      );
    }
    return Timeline.tileBuilder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      theme: TimelineThemeData(
        nodePosition: 0,
        connectorTheme: const ConnectorThemeData(
          thickness: 3.0,
          color: Color(0xffd3d3d3),
        ),
        indicatorTheme: const IndicatorThemeData(
          size: 15.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      builder: TimelineTileBuilder.connected(
        contentsBuilder: (_, index) {
          if (status > index) {
            return Padding(
              padding: EdgeInsetsDirectional.only(start: 10.w),
              child: Text(
                etats.entries.elementAt(index).value.tr,
                style: GoogleFonts.montserrat(
                    fontSize: 12.sp, fontWeight: FontWeight.w700),
              ),
            );
          } else if (status == index) {
            if (status == 4) {
              return Padding(
                padding: EdgeInsetsDirectional.only(start: 10.w),
                child: Text(
                  etats.entries.elementAt(index).value.tr,
                  style: GoogleFonts.montserrat(
                      color: const Color.fromRGBO(40, 167, 69, 1),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700),
                ),
              );
            }
            return Padding(
              padding: EdgeInsetsDirectional.only(start: 10.w),
              child: Text(
                etats.entries.elementAt(index).value.tr,
                style: GoogleFonts.montserrat(
                    color: const Color.fromRGBO(255, 215, 71, 1),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700),
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsetsDirectional.only(start: 10.w),
              child: Text(
                etats.entries.elementAt(index).value.tr,
                style: GoogleFonts.montserrat(
                    color: const Color.fromRGBO(217, 217, 217, 1),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700),
              ),
            );
          }
        },
        connectorBuilder: (_, index, __) {
          if (status <= index) {
            return const DashedLineConnector(
                color: AppColors.INACTIVE_GREY_COLOR);
          } else {
            return const DashedLineConnector(
                color: Color.fromRGBO(40, 167, 69, 1));
          }
        },
        indicatorBuilder: (_, index) {
          if (status > index) {
            return const OutlinedDotIndicator(
              color: Color.fromRGBO(40, 167, 69, 1),
              borderWidth: 2.0,
              backgroundColor: Colors.white,
            );
          } else if (status == index) {
            if (status == 4) {
              return const OutlinedDotIndicator(
                color: Color.fromRGBO(40, 167, 69, 1),
                borderWidth: 2.0,
                backgroundColor: Colors.white,
              );
            }
            return const OutlinedDotIndicator(
              color: Color.fromRGBO(255, 215, 71, 1),
              borderWidth: 2.0,
              backgroundColor: Colors.white,
            );
          } else {
            return const OutlinedDotIndicator(
              color: Color(0xffbabdc0),
              backgroundColor: Colors.white,
            );
          }
        },
        itemExtentBuilder: (_, __) => kTileHeight,
        itemCount: 5,
      ),
    );
  }
}

enum _TimelineStatus {
  done,
  sync,
  inProgress,
  todo,
}

extension on _TimelineStatus {
  bool get isInProgress => this == _TimelineStatus.inProgress;
}
