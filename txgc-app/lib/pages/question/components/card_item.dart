import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardItem extends StatelessWidget {
  final List<Map> statusList;
  final Map item;
  final Widget Function(BuildContext context, Map item) operation;

  CardItem(this.item, this.statusList, this.operation);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      width: 700.w,
      height: 303.h,
      decoration: BoxDecoration(
          color: Color(0xFFF5F6FA), borderRadius: BorderRadius.circular(10.w)),
      constraints: BoxConstraints(minHeight: 262.h),
      child: Stack(
        children: [
          _taskStatus(statusList[item['status']]['title'],
              statusList[item['status']]['color']),
          item['status'] == 0 ? _taskDeadline() : Container(),
          _taskBody(context),
        ],
      ),
    );
  }

  Widget _taskDeadline() {
    return Positioned.fill(
        child: Container(
      decoration: BoxDecoration(
          color: Color(0xFFFF6565).withOpacity(0.15),
          borderRadius: BorderRadius.circular(10.w),
          border: Border.all(width: 2.w, color: Color(0xFFFF6565))),
      child: Stack(
        children: [
          Positioned(
              right: 10.w,
              bottom: 13.h,
              child: Image.asset(
                'images/order-deadline.png',
                width: 139.w,
              ))
        ],
      ),
    ));
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
    return Positioned(
        top: 30.h,
        left: 30.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _taskTitle(),
            _taskProject('images/project.png', '杭绍台工程'),
            _taskUser(),
            _taskProject('images/time.png', '截止时间${item['createDate']}'),
            operation(context, item)
          ],
        ));
  }

  Widget _taskTitle() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 12.w),
          constraints: BoxConstraints(maxWidth: 208.w),
          padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.w),
              border: Border.all(width: 2.w, color: Color(0xFF009CFF))),
          child: Text(
            item['number'],
            style: TextStyle(
              fontSize: 20.sp,
              color: Color(0xFF009CFF),
              height: 1.0,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Container(
          width: 420.w,
          child: Text(
            item['title'],
            style: TextStyle(
              fontSize: 32.sp,
              color: Colors.black,
              height: 1.0,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        )
      ],
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
          child: Text(
            '由${item['username']}发起',
            style: TextStyle(
              color: Color(0xFF999999),
              fontSize: 24.sp,
              height: 1.0,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
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
            '发起时间：${item['createDate']}',
            style: TextStyle(
              color: Color(0xFF999999),
              fontSize: 24.sp,
              height: 1.0,
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
