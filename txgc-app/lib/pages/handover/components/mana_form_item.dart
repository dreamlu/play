import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/form_item.dart';

class ManaFormItem extends FormItem {
  ManaFormItem(
    String name,
    String label,
    String placeholder, {
    TextInputType keyboardType,
    String hintText,
    void Function(TextEditingController controller) onTap,
    void Function() onPicker,
    bool isCode = false,
    bool isClear = false,
    bool isMedia = false,
    bool isCustPicker = false,
    int minLines = 1,
    String value,
    GestureTapCallback onVerifyCodeTap,
  }) : super(name, label, placeholder,
            keyboardType: keyboardType,
            hintText: hintText,
            onTap: onTap,
            onPicker: onPicker,
            isCode: isCode,
            isClear: isClear,
            value: value,
            isMedia: isMedia,
            isCustPicker: isCustPicker,
            minLines: minLines,
            onVerifyCodeTap: onVerifyCodeTap,
            isCodeBoxStyle: false,
            isBorder: false,
            textAlign: TextAlign.start,
            formItemPadding: EdgeInsets.only(right: 27.w, bottom: 20.w),
            layout: 'horizontal',
            formItemMargin: EdgeInsets.only(
              left: 27.w,
            ));
}
