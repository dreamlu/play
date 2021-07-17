import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/model/order.dart';

class CardItem extends StatelessWidget {
  final List<Map> statusList;
  final Order item;
  final Widget Function(BuildContext context, Order item) operation;

  CardItem(this.item, this.statusList, this.operation);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      width: 700.w,
      padding: EdgeInsets.only(left: 30.w, bottom: 30.h),
      decoration: BoxDecoration(
          border: item.status == 2
              ? Border.all(width: 2.w, color: Color(0xFFFF6565))
              : null,
          color: item.status == 2
              ? Color(0xFFFF6565).withOpacity(0.15)
              : Color(0xFFF5F6FA),
          borderRadius: BorderRadius.circular(10.w),
          image: item.status == 2
              ? DecorationImage(
                  image: AssetImage('images/order-deadline.png'),
                  alignment: Alignment(0.95, 0.9))
              : null),
      child: _taskBody(context),
    );
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
        _taskUser(),
        _taskProject('images/time.png', '截止时间${item.endTime}'),
        operation(context, item)
      ],
    );
  }

  Widget _taskTitle() {
    return Container(
      width: 700.w,
      child: Stack(
        children: [
          _taskStatus(statusList[item.status]['title'],
              statusList[item.status]['color']),
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

  Widget _taskUser() {
    return Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_taskInitiate(), _taskTime()],
        ));
  }

  Widget _taskInitiate() {
    return Container(
        child: Row(
      children: [
        Image.asset(
          'images/user.png',
          fit: BoxFit.cover,
        ),
        Container(
          margin: EdgeInsets.only(left: 10.w, right: 13.w),
          padding: EdgeInsets.only(right: 14.w),
          constraints: BoxConstraints(maxWidth: 195.w),
          child: Text(
            '由${item.projectPersonName}发起',
            style: TextStyle(
              color: Color(0xFF999999),
              fontSize: 24.sp,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Color(0xFF999999)))),
        )
      ],
    ));
  }

  Widget _taskTime() {
    return Container(
        child: Row(
      children: [
        Image.asset(
          'images/time.png',
          fit: BoxFit.cover,
        ),
        Container(
          margin: EdgeInsets.only(left: 4.w, right: 13.w),
          padding: EdgeInsets.only(right: 14.w),
          child: Text(
            '发起时间：${item.createTime}',
            style: TextStyle(
              color: Color(0xFF999999),
              fontSize: 24.sp,
            ),
          ),
        )
      ],
    ));
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
