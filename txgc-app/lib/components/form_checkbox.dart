import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/form_radius.dart';
import 'package:txgc_app/utils/global.dart';

class CheckBoxType {
  String label;
  String value;
  bool isCheck;
  bool single;
  CheckBoxType(this.label, this.isCheck, this.value, {this.single = false});
}

class FormCheckBox extends StatelessWidget {
  final List<CheckBoxType> data;
  final String label;
  final String tooltips;
  final bool single;
  FormCheckBox(this.label, this.data, {this.single = false, this.tooltips});
  @override
  Widget build(BuildContext context) {
    ValueNotifier vn = ValueNotifier<String>('');
    return Container(
      margin: EdgeInsets.only(
        left: 25.w,
        bottom: 40.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: 25.h,
            ),
            child: Text(
              label,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w500),
            ),
          ),
          tooltips != null
              ? Container(
                  margin: EdgeInsets.only(
                    bottom: 25.h,
                  ),
                  child: Text(
                    tooltips,
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 24.sp,
                    ),
                  ),
                )
              : Container(),
          Row(
              children: data
                  .map((item) => CheckBoxItem(
                      item.label, item.value, item.isCheck, vn,
                      single: single))
                  .toList())
        ],
      ),
    );
  }
}

class CheckBoxItem extends StatefulWidget {
  final String label;
  final String value;
  final bool isCheck;
  final bool single;
  final ValueNotifier<String> vn;
  CheckBoxItem(this.label, this.value, this.isCheck, this.vn, {this.single});
  @override
  _CheckBoxItemState createState() => _CheckBoxItemState();
}

class _CheckBoxItemState extends State<CheckBoxItem> {
  bool isCheck;

  @override
  void initState() {
    super.initState();
    isCheck = widget.isCheck;
    if (isCheck) {
      widget.vn.value = widget.value;
    }
  }

  void handleTap() {
    setState(() {
      isCheck = !isCheck;
      widget.vn.value = widget.value;
      Global.formRecord[widget.value] = isCheck;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 83.w,
      ),
      child: InkWell(
        onTap: handleTap,
        child: Row(
          children: [
            ValueListenableBuilder(
              valueListenable: widget.vn,
              // value前面的int代表值的类型，使用时一定明确指定该类型
              builder: (BuildContext context, String value, Widget child) {
                if (widget.single) {
                  return FormRadius(
                    isCheck: value == widget.value,
                  );
                } else {
                  return FormRadius(
                    isCheck: isCheck,
                  );
                }
              },
            ),
            Container(
              margin: EdgeInsets.only(left: 15.w),
              child: Text(
                widget.label,
                style: TextStyle(color: Color(0xFF010101), fontSize: 30.sp),
              ),
            )
          ],
        ),
      ),
    );
  }
}
