import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskTitle extends StatelessWidget {
  final String title;
  final Widget child;
  TaskTitle(this.title, {this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 26.w),
      padding: EdgeInsets.only(bottom: 50.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 30.h),
            child: Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 32.sp),
            ),
          ),
          child
        ],
      ),
    );
  }
}
