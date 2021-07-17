import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PannelItem extends StatelessWidget {
  final String statusDesc;
  final Color statusBg;
  final String createTime;
  final String content;
  final bool isOver;
  final GestureTapCallback onTap;
  PannelItem(
      {@required this.statusDesc,
      @required this.statusBg,
      @required this.createTime,
      this.content = '',
      this.isOver = false,
      this.onTap})
      : assert(statusDesc != null && statusBg != null && createTime != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: [_title(), _navBody(context)],
      ),
    );
  }

  Widget _title() {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      child: Row(
        children: [
          _tag(),
          Container(
            margin: EdgeInsets.only(left: 16.w),
            child: Text(
              createTime,
              style: TextStyle(color: Color(0xFF999999), fontSize: 24.sp),
            ),
          )
        ],
      ),
    );
  }

  Widget _tag() {
    return Container(
      decoration: BoxDecoration(
          color: statusBg, borderRadius: BorderRadius.circular(18.w)),
      padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 16.w),
      child: Text(
        statusDesc,
        style: TextStyle(fontSize: 24.sp, color: Colors.white),
      ),
    );
  }

  Widget _navBody(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 700.w,
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 25.w),
        margin: EdgeInsets.only(bottom: 40.h),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.w)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              content,
              style: TextStyle(
                  color: isOver ? Color(0xFF666666) : Colors.black,
                  fontSize: 28.sp),
            ),
            Container(
              margin: EdgeInsets.only(
                right: 25.w,
              ),
              child: Image.asset('images/right-tri.png'),
            )
          ],
        ),
      ),
    );
  }
}
