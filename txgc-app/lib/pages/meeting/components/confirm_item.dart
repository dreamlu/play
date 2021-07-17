import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/model/meeting.dart';

class ConfirmItem extends StatelessWidget {
  final JoinIds item;
  final Function(bool isConfirm) onTap;
  ConfirmItem(this.item, {this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(minHeight: 115.h),
        margin: EdgeInsets.only(left: 30.w, right: 30.w),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 2.w, color: Color(0xFFE6E6E6)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_userInfo(), _userStatus()],
        ));
  }

  Widget _userStatus() {
    return Container(
      margin: EdgeInsets.only(right: 28.w),
      child: Text(
        item.status == 1 ? '已确认' : '未确认',
        style: TextStyle(
            color: item.status == 1 ? Color(0xFF009CFF) : Color(0xFFEF1D26),
            fontSize: 30.sp),
      ),
    );
  }

  Widget _userInfo() {
    return Expanded(
        child: Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 24.w, right: 40.w),
            child: Text(
              item.name,
              style: TextStyle(color: Color(0xFF010101), fontSize: 30.sp),
            ),
          ),
        ],
      ),
    ));
  }
}
