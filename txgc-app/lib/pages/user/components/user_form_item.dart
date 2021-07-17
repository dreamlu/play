import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/form_item.dart';

class UserFormItem extends FormItem {
  UserFormItem(
    String name,
    String label,
    String placeholder, {
    TextInputType keyboardType,
    String hintText,
    EdgeInsetsGeometry formItemPadding,
    bool obscureText = false,
    void Function(TextEditingController controller) onTap,
    GestureTapCallback onVerifyCodeTap,
  }) : super(name, label, placeholder,
            keyboardType: keyboardType,
            hintText: hintText,
            onTap: onTap,
            isClear: false,
            obscureText: obscureText,
            formLabelMargin: EdgeInsets.only(bottom: 24.h),
            custBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.w),
                borderSide: BorderSide(width: 2.w, color: Color(0xFF999999))),
            isBorder: false,
            formLabelFontSize: 26,
            formItemWidth: 600,
            onVerifyCodeTap: onVerifyCodeTap,
            layout: 'horizontal',
            formItemPadding: formItemPadding,
            formItemMargin: EdgeInsets.only(left: 83.w, right: 60.w));
}
