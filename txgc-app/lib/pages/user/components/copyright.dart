import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Copyright extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 30.h),
      child: Column(
        children: [
          Text(
            'Copyright@2021-2022',
            style: TextStyle(color: Color(0xFF999999), fontSize: 24.sp),
          ),
          Text(
            '通号北分施工管理系统',
            style: TextStyle(color: Color(0xFF999999), fontSize: 24.sp),
          )
        ],
      ),
    );
  }
}
