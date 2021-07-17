import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Hr extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  Hr({this.margin});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.h,
      margin: margin,
      color: Color(0xfff7f7f7),
    );
  }
}
