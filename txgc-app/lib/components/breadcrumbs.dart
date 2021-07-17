import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Breadcrumbs extends StatelessWidget {
  final String label;
  Breadcrumbs(this.label);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 750.w,
      decoration: BoxDecoration(
          border: Border.all(width: 1.w, color: Color(0xFFEEEEEE))),
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Row(
        children: [
          RotatedBox(
            quarterTurns: 2,
            child: Image.asset('images/right-tri.png'),
          ),
          BreadcrumbsItem(label),
        ],
      ),
    );
  }
}

class BreadcrumbsItem extends StatelessWidget {
  final String label;
  BreadcrumbsItem(this.label);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        width: 630.w,
        margin: EdgeInsets.only(left: 19.w),
        child: Text(
          '$label',
          style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 32.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
