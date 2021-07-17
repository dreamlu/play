import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/form_item.dart';

class QuestionFormItem extends FormItem {
  QuestionFormItem(
    String name,
    String label,
    String placeholder, {
    TextInputType keyboardType,
    String hintText,
    String value,
    void Function(TextEditingController controller) onTap,
    void Function() onPicker,
    bool enabled = true,
    bool isCode = false,
    bool isClear = false,
    bool isMedia = false,
    bool isAutoWrap = false,
    List mediaType = const ['camera'],
    final Widget suffix, // 表单前缀修饰
    final Widget prefix, // 表单后缀修饰
    bool isCustPicker = false,
    int minLines = 1,
    GestureTapCallback onVerifyCodeTap,
  }) : super(name, label, placeholder,
            keyboardType: keyboardType,
            hintText: hintText,
            onTap: onTap,
            onPicker: onPicker,
            suffix: suffix,
            prefix: prefix,
            isCode: isCode,
            mediaType: mediaType,
            isClear: isClear,
            value: value,
            isMedia: isMedia,
            enabled: enabled,
            isAutoWrap: isAutoWrap,
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
