import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/utils/global.dart';

class NavBack extends StatelessWidget {
  final Color iconColor;

  NavBack({this.iconColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: Global.statusBarHeight.h,
        left: 21.w,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: 100.w,
            height: 100.h,
            alignment: Alignment.topLeft,
            child: Image.asset(
              'images/chevron-left-rounded.png',
              color: iconColor,
            ),
          ),
        ));
  }
}
