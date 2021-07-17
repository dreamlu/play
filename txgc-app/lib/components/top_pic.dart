import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopPic extends StatelessWidget {
  final String src;
  TopPic(this.src);
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        child: Container(
          width: 750.w,
          height: 300.h,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(src),
            fit: BoxFit.fitHeight,
          )),
          child: Image.asset(
            src,
          ),
        ));
  }
}
