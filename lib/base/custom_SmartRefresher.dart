import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomSmartRefresher extends StatefulWidget {
  RefreshController? controller;
  Widget? child;
  void Function()? onRefresh;
  void Function()? onLoading;
  bool enablePullDown;
  bool enablePullUp;
  String? lodingText;
  String? noResultText;
  CustomSmartRefresher(
      {Key? key,
      this.controller,
      this.child,
      this.onRefresh,
      this.onLoading,
      this.enablePullDown = true,
      this.enablePullUp = false,
      this.noResultText = "no result",
      this.lodingText = "loding page"})
      : super(key: key);

  @override
  _CustomSmartRefresherState createState() => _CustomSmartRefresherState();
}

class _CustomSmartRefresherState extends State<CustomSmartRefresher> {
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: widget.enablePullDown,
      enablePullUp: widget.enablePullUp,
      header: WaterDropHeader(
        waterDropColor: Colors.blue,
        complete: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check,
              color: Colors.blue,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Loading Page".tr,
              style: const TextStyle(
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("");
          } else if (mode == LoadStatus.loading) {
            body = const CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed!Click retry!".tr);
          } else if (mode == LoadStatus.canLoading) {
            body = Column(
              children: [
                Text(
                  "swipe for more".tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.blue,
                  size: 35,
                )
              ],
            );
          } else {
            body = Text(
              "no more result".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.blue,
              ),
            );
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: widget.controller!,
      onRefresh: widget.onRefresh!,
      onLoading: widget.onLoading!,
      child: widget.child,
    );
  }
}
