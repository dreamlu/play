import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/form_item.dart';

class SettingFormItem extends FormItem {
  SettingFormItem(
    String name,
    String label,
    String placeholder, {
    TextInputType keyboardType,
    String hintText,
    void Function(TextEditingController controller) onTap,
    bool isCode = false,
    bool isClear = false,
    GestureTapCallback onVerifyCodeTap,
  }) : super(name, label, placeholder,
            keyboardType: keyboardType,
            hintText: hintText,
            onTap: onTap,
            isCode: isCode,
            isBorder: false,
            isClear: isClear,
            onVerifyCodeTap: onVerifyCodeTap,
            formItemHeight: 118.h,
            isCodeBoxStyle: false,
            layout: 'horizontal',
            formItemPadding: EdgeInsets.only(right: 25.w, left: 25.w));
}
