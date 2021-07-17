import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/model/car_driver.dart';

class CardItem extends StatelessWidget {
  final CarDriver item;
  final Widget Function(BuildContext context, CarDriver item) operation;

  CardItem(this.item, this.operation);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      width: 700.w,
      padding: EdgeInsets.only(left: 30.w, bottom: 30.h, top: 30.h),
      decoration: BoxDecoration(
          color: Color(0xFFF5F6FA), borderRadius: BorderRadius.circular(10.w)),
      child: _taskBody(context),
    );
  }

  Widget _taskBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _taskTitle(),
        _taskProject('images/project.png', '当前所在工程：杭绍台工程'),
        _taskProject('images/car.png', '当前驾驶车辆：京A12569'),
        operation(context, item)
      ],
    );
  }

  Widget _taskTitle() {
    return Container(
      width: 600.w,
      child: Text(
        item.name,
        style: TextStyle(
          fontSize: 32.sp,
          color: Colors.black,
          height: 1.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _taskProject(String icon, String title) {
    List<Widget> _widgetList = [
      Image.asset(
        icon,
        fit: BoxFit.cover,
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w),
        constraints: BoxConstraints(maxWidth: 600.w),
        child: Text(
          title,
          style: TextStyle(
            color: Color(0xFF999999),
            fontSize: 24.sp,
          ),
        ),
      )
    ];

    return Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _widgetList,
        ));
  }
}
