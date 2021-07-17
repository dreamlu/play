import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderTitle extends StatelessWidget {
  final String title;
  final String desc;
  HeaderTitle(this.title, this.desc);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 26.w, top: 41.h, bottom: 15.h),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 32.sp,
                fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(left: 33.w),
            child: Text(
              desc,
              style: TextStyle(color: Color(0xFF999999), fontSize: 26.sp),
            ),
          ),
        ],
      ),
    );
  }
}
