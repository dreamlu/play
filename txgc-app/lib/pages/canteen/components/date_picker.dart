import 'package:day/day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/utils/index.dart';

class DatePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 300.h,
        child: Container(
          height: 100.h,
          width: 750.w,
          child: Row(
            children: [
              DateItem('开始日期'),
              Container(
                width: 1.w,
                height: 26.h,
                color: Color(0xFFB2B2B2),
              ),
              DateItem('结束日期'),
            ],
          ),
        ));
  }
}

class DateItem extends StatefulWidget {
  final String label;
  DateItem(this.label);
  @override
  _DateItemState createState() => _DateItemState();
}

class _DateItemState extends State<DateItem> {
  String date;

  @override
  void initState() {
    super.initState();
    date = ' 请选择';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDatePickerModal(context, type: PickerDateTimeType.kYMD,
            onConfirm: (Picker picker, List value) {
          print(picker.adapter.text);
          setState(() {
            date = Day.fromString(picker.adapter.text).format('YYYY-MM-DD');
          });
        }, onSelect: (Picker picker, int index, List<int> selecteds) {});
      },
      child: Container(
        width: 374.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${widget.label}：$date',
              style: TextStyle(color: Color(0xFF000000), fontSize: 28.sp),
            ),
            Container(
              margin: EdgeInsets.only(left: 19.w),
              child: Image.asset(
                'images/right-solid-tri.png',
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}
