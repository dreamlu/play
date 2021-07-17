import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeekendTab extends StatefulWidget {
  @override
  _WeekendTabState createState() => _WeekendTabState();
}

class _WeekendTabState extends State<WeekendTab> {
  int tabIdx;
  List week = [
    '一',
    '二',
    '三',
    '四',
    '五',
    '六',
    '日',
  ];
  @override
  void initState() {
    super.initState();
    tabIdx = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 300.h,
        child: Container(
          height: 100.h,
          width: 750.w,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1.w, color: Color(0xFFEEEEEE))),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: week
                  .map((item) => _weekendItem(
                          context, item, tabIdx == week.indexOf(item), () {
                        setState(() {
                          tabIdx = week.indexOf(item);
                        });
                      }))
                  .toList()),
        ));
  }

  Widget _weekendItem(BuildContext context, String label, bool isActive,
      void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 3.w,
                    color: Color(0xFF009CFF).withOpacity(isActive ? 1 : 0)))),
        child: Text(
          '周$label',
          style: TextStyle(
              color: isActive ? Color(0xFF009CFF) : Color(0xFF000000),
              fontSize: 28.sp),
        ),
      ),
    );
  }
}
