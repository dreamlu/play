import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardItem extends StatelessWidget {
  final List<Map> statusList;
  final Map item;
  final bool isType;
  final Widget Function(BuildContext context, Map item) operation;

  CardItem(this.item, this.statusList, this.operation, {this.isType = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      width: 700.w,
      height: 262.h,
      constraints: BoxConstraints(minHeight: 262.h),
      decoration: BoxDecoration(
          color: Color(0xFFF5F6FA), borderRadius: BorderRadius.circular(10.w)),
      child: Stack(
        children: [
          _taskStatus(statusList[item['status']]['title'],
              statusList[item['status']]['color']),
          _taskBody(context)
        ],
      ),
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
    return Positioned(
        top: 30.h,
        left: 30.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _taskTitle(),
            _taskProject(),
            _taskUser(),
            operation(context, item)
          ],
        ));
  }

  Widget _taskTitle() {
    return Container(
      width: 640.w,
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
    );
  }

  Widget _taskProject() {
    List<Widget> _widgetList = [
      Image.asset(
        'images/project.png',
        fit: BoxFit.cover,
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w),
        constraints: BoxConstraints(maxWidth: isType ? 300.w : 600.w),
        child: Text(
          item['project'],
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

    if (isType) {
      _widgetList.addAll([
        Container(
          margin: EdgeInsets.only(
            left: 16.w,
          ),
          padding: EdgeInsets.only(
            left: 13.w,
          ),
          decoration: BoxDecoration(
              border: Border(left: BorderSide(color: Color(0xFF999999)))),
          child: Image.asset(
            'images/type.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 6.w,
          ),
          constraints: BoxConstraints(maxWidth: 265.w),
          child: Text(
            item['type'],
            style: TextStyle(
              color: Color(0xFF999999),
              fontSize: 24.sp,
              height: 1.0,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        )
      ]);
    }

    return Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _widgetList,
        ));
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
            '由${item['username']}是发起',
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
}
