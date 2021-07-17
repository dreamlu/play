import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/model/file_receive.dart';

class CardItem extends StatelessWidget {
  final List<Map> statusList;
  final FileReceive item;
  final int tabIdx;
  final bool isType;
  final Widget Function(BuildContext context, FileReceive item) operation;

  CardItem(
    this.item,
    this.statusList,
    this.operation, {
    this.isType = false,
    this.tabIdx,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 15.h),
        padding: EdgeInsets.only(left: 30.w, bottom: 30.h),
        width: 700.w,
        decoration: BoxDecoration(
            color: Color(0xFFF5F6FA),
            borderRadius: BorderRadius.circular(10.w)),
        child: _taskBody(context));
  }

  Widget _taskStatus(String name, Color color) {
    return Positioned(
        right: 0,
        top: 0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.w),
                bottomLeft: Radius.circular(10.w),
              )),
          child: Text(
            name,
            style: TextStyle(color: Colors.white, fontSize: 24.sp, height: 1.1),
          ),
        ));
  }

  Widget _taskBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _taskTitle(),
        _taskProject(
            'images/user.png',
            tabIdx == 0
                ? '由${item.name}发布'
                : '浏览人员：${item.receiveIds.map((e) => e.name).join(',')}'),
        _taskProject('images/clock.png', '浏览截至时间：${item.endTime ?? ''}'),
        operation(context, item)
      ],
    );
  }

  Widget _taskTitle() {
    return Container(
      width: 700.w,
      child: Stack(
        children: [
          _taskStatus(statusList[item.receiveStatus]['title'],
              statusList[item.receiveStatus]['color']),
          Container(
            width: 600.w,
            padding: EdgeInsets.only(top: 30.h),
            child: Text(
              item.name,
              style: TextStyle(
                fontSize: 32.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
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
            height: 1.0,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
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
