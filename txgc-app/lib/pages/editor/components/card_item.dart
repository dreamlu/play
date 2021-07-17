import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/model/share_edit.dart';

class CardItem extends StatelessWidget {
  final List<Map> statusList;
  final int tabIdx;
  final ShareEdit item;
  final Widget Function(BuildContext context, ShareEdit item) operation;

  CardItem(this.item, this.statusList, this.operation, this.tabIdx);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      width: 700.w,
      padding: EdgeInsets.only(left: 30.w, bottom: 30.h),
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
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
            ),
          ),
        ));
  }

  Widget _taskBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _taskTitle(),
        _taskProject(title: item.content),
        _taskProject(
            icon: 'images/type.png',
            title:
                '${item.isPublic == 1 ? '公开' : '非公开'}、${item.isAy == 1 ? '匿名' : '非匿名'}'),
        _taskProject(
            icon: 'images/user.png', title: '由${item.projectPersonName}发起'),
        operation(context, item)
      ],
    );
  }

  Widget _taskTitle() {
    return Container(
      width: 700.w,
      child: Stack(
        children: [
          tabIdx == 0
              ? _taskStatus(statusList[item.receiveStatus]['title'],
                  statusList[item.receiveStatus]['color'])
              : Container(),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 12.w, top: 30.h),
                constraints: BoxConstraints(maxWidth: 208.w),
                padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.w),
                    border: Border.all(width: 2.w, color: Color(0xFF009CFF))),
                child: Text(
                  '自助编辑',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Color(0xFF009CFF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: tabIdx == 0 ? 450.w : 540.w,
                margin: EdgeInsets.only(top: 30.h),
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
          )
        ],
      ),
    );
  }

  Widget _taskProject({String icon, String title}) {
    List<Widget> _widgetList = [];

    if (icon != null) {
      _widgetList.add(Image.asset(
        icon,
        fit: BoxFit.cover,
      ));
    }

    _widgetList.add(Container(
      margin: EdgeInsets.only(left: icon != null ? 10.w : 0),
      constraints: BoxConstraints(maxWidth: 650.w),
      child: Text(
        title,
        style: TextStyle(
          color: Color(0xFF999999),
          fontSize: 24.sp,
        ),
      ),
    ));

    return Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _widgetList,
        ));
  }
}
