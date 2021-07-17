import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/model/signature.dart';

class CardItem extends StatelessWidget {
  final List<Map> statusList;
  final Signature item;
  final Widget Function(BuildContext context, Signature item) operation;

  CardItem(
    this.item,
    this.statusList,
    this.operation,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      padding: EdgeInsets.only(left: 30.w, bottom: 30.h),
      width: 700.w,
      decoration: BoxDecoration(
          color: Color(0xFFF5F6FA), borderRadius: BorderRadius.circular(10.w)),
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
            style: TextStyle(color: Colors.white, fontSize: 24.sp),
          ),
        ));
  }

  Widget _taskBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _taskTitle(),
        _taskProject(),
        _taskUser(),
        operation(context, item)
      ],
    );
  }

  Widget _taskTitle() {
    return Container(
      width: 700.w,
      child: Stack(
        children: [
          _taskStatus(statusList[item.signStatus]['title'],
              statusList[item.signStatus]['color']),
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

  Widget _taskProject() {
    List<Widget> _widgetList = [
      Image.asset(
        'images/project.png',
        fit: BoxFit.cover,
      ),
      Container(
        margin: EdgeInsets.only(left: 10.w),
        constraints: BoxConstraints(maxWidth: 300.w),
        child: Text(
          item.projectName,
          style: TextStyle(
            color: Color(0xFF999999),
            fontSize: 24.sp,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      )
    ];

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
          item.prSignatureCategoryName,
          style: TextStyle(
            color: Color(0xFF999999),
            fontSize: 24.sp,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      )
    ]);

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
            '由${item.projectPersonName}是发起',
            style: TextStyle(
              color: Color(0xFF999999),
              fontSize: 24.sp,
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
            '发起时间：${item.createTime}',
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
