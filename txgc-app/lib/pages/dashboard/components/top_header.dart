import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 750.w,
      height: 256.h,
      child: Stack(
        children: [_body(), _bgPic()],
      ),
    );
  }

  Widget _body() {
    return Positioned(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 22.h),
          child: Image.asset('images/dot.png'),
        ),
        Text(
          '陈柯汶，欢迎您使用',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.sp,
          ),
        ),
        Text(
          '通号北分施工管理系统',
          style: TextStyle(
              color: Colors.black,
              fontSize: 42.sp,
              height: 1.5,
              fontWeight: FontWeight.bold),
        ),
        Text(
          'Welcome to use the construction management \nsystem of the Beijing branch',
          style: TextStyle(color: Color(0xFFB2B2B2), fontSize: 20.sp),
        ),
      ],
    ));
  }

  Widget _bgPic() {
    return Positioned(
        right: 0, top: 0, child: Image.asset('images/dashboard-pic.png'));
  }
}
