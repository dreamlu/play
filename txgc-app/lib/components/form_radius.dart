import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormRadius extends StatelessWidget {
  final bool isCheck;
  final bool isDisabled;
  final double width;
  final double height;
  FormRadius(
      {this.isCheck = false,
      this.isDisabled = false,
      this.width = 35,
      this.height = 35});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
      width: width.w,
      height: height.w,
      child: Image.asset(
        'images/correct.png',
        width: 23.w,
        height: 17.h,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.w),
          color: isDisabled
              ? Color(0xFFEEEEEE)
              : isCheck
                  ? Color(0xFF009CFF)
                  : Colors.white,
          border: Border.all(
              width: 1.w,
              color: isCheck ? Color.fromARGB(0, 0, 0, 0) : Color(0xFF999999))),
    ));
  }
}
