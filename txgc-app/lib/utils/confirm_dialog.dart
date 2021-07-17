import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 二次操作对话框
/// [title] 标题
/// [desc] 内容
/// [cancelText] 取消
/// [okText] 确认
Future<bool> confirmDialog(
  BuildContext context, {
  String title = '提示',
  String desc = '您确定要执行此操作吗?',
  String cancelText = '取消',
  String okText = '删除',
}) {
  Widget _btn(BuildContext context, String label, Color color,
      {void Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60.w,
        margin: EdgeInsets.only(top: 29.h),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 60.w),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(30.w)),
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 24.sp),
        ),
      ),
    );
  }

  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 32.sp),
          textAlign: TextAlign.center,
        ),
        content: Wrap(
          children: [
            Text(
              desc,
              style: TextStyle(color: Color(0xFFB2B2B2), fontSize: 24.sp),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _btn(context, cancelText, Color(0xFFD2D2D2), onTap: () {
                  Navigator.of(context).pop(false);
                }),
                _btn(context, okText, Color(0xFFFF6565), onTap: () {
                  Navigator.of(context).pop(true);
                }),
              ],
            )
          ],
        ),
      );
    },
  );
}
