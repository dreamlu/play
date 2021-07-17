import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:txgc_app/utils/global.dart';

/// 通用弹框
/// [hintText] 表单提示语
/// [formKey] 表单提交key
/// [minLines] 表单最大行数
/// [title] 标题
/// [titleColor] 标题颜色
/// [desc] 副标题
/// [cancelTitle] 取消文字描述
/// [cancelBgColor] 取消文字背景
/// [okTitle] 确定文字描述
/// [okBgColor] 确定文字背景
Future<bool> globalModal(BuildContext context,
    {TextInputType keyboardType = TextInputType.text,
    String hintText,
    String formKey,
    int maxLines = 1,
    String title,
    Color titleColor,
    String desc,
    String cancelTitle,
    Color cancelBgColor,
    String okTitle,
    Color okBgColor}) {
  Widget _btn(BuildContext context, String title, Color bgColor,
      GestureTapCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(30.w)),
        width: 190.h,
        height: 60.h,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 24.sp),
        ),
      ),
    );
  }

  Widget _formInput(
    BuildContext context,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 30.h),
      padding: EdgeInsets.symmetric(horizontal: 19.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.w),
          border: Border.all(width: 1.w, color: Color(0xFFB2B2B2))),
      child: TextField(
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: 24.sp,
        ),
        maxLines: maxLines,
        onChanged: (String value) {
          Global.formRecord[formKey] = value;
        },
        decoration: InputDecoration(
            hintStyle: TextStyle(
              color: Color(0xFFB2B2B2),
              fontSize: 24.sp,
            ),
            border: InputBorder.none,
            hintText: hintText),
      ),
    );
  }

  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
          title: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 32.sp, color: titleColor),
              ),
              desc != null
                  ? Text(
                      desc,
                      style: TextStyle(
                          fontSize: 24.sp,
                          color: Color(0xFF999999),
                          fontWeight: FontWeight.normal),
                    )
                  : Container()
            ],
          ),
          content: Wrap(
            children: [
              _formInput(
                context,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _btn(context, cancelTitle, cancelBgColor, () {
                    Navigator.of(context).pop(false);
                  }),
                  _btn(context, okTitle, okBgColor, () {
                    if (Global.formRecord[formKey] == null ||
                        Global.formRecord[formKey] == '') {
                      showToast(hintText);
                      return;
                    }
                    Navigator.of(context).pop(true);
                  }),
                ],
              )
            ],
          ));
    },
  );
}
