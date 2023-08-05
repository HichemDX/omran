import 'package:bnaa/models/normalButtonWithBorderModel.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class NormalButtonWithBorder extends StatelessWidget {
  NormalButtonWithBorderModel model;
  NormalButtonWithBorder({required this.model});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        model.onTap();
      },
      child: Container(
        height: model.height,
        width: model.width,
        decoration: BoxDecoration(
          border: Border.all(width: model.wBorder, color: model.bColor),
          color: model.colorButton,
          borderRadius: BorderRadius.circular(model.radius),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Center(
            child: Text(model.text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: model.colorText,
                  fontSize: model.textFontSize,
                  fontWeight: FontWeight.w500,
                )),
          ),
        ),
      ),
    );
  }
}
