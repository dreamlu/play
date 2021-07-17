import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/model/meeting.dart';
import 'package:txgc_app/utils/global.dart';

class CardItem extends StatelessWidget {
  final List<Map> statusList;
  final Meeting item;
  final int tabIdx;
  final Widget Function(BuildContext context, Meeting item) operation;

  CardItem(this.item, this.statusList, this.operation, {this.tabIdx});
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
            style: TextStyle(color: Colors.white, fontSize: 24.sp, height: 1.1),
          ),
        ));
  }

  Widget _taskBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _taskTitle(),
        _taskProject('images/time-start.png', '开始时间：${item.startTime}'),
        _taskProject('images/type.png', '会议地点：${item.plat}'),
        _taskUser(),
        _taskProject('images/user-group.png',
            '参与人员：${item.joinIds.map((e) => e.name).join(',')}'),
        _taskProject('images/remark.png', '会议备注：${item.remark}'),
        operation(context, item)
      ],
    );
  }

  Widget _taskTitle() {
    Color color = item?.typ == 1 ? Color(0xFF009CFF) : Color(0xFFFF7E00);

    return Container(
      width: 700.w,
      child: Stack(
        children: [
          _taskStatus(statusList[item.status]['title'],
              statusList[item.status]['color']),
          Container(
            width: 600.w,
            padding: EdgeInsets.only(top: 30.h),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 12.w),
                  constraints: BoxConstraints(maxWidth: 208.w),
                  padding:
                      EdgeInsets.symmetric(vertical: 9.h, horizontal: 10.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.w),
                      border: Border.all(width: 2.w, color: color)),
                  child: Text(
                    item.typ == 0 ? '线下' : '线上',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  width: 420.w,
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
          children: [
            tabIdx == 1 ? _taskInitiate() : Container(),
            _taskRecording()
          ],
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
            '由张三${item.name}发起',
            style: TextStyle(
              color: Color(0xFF999999),
              fontSize: 24.sp,
              height: 1.0,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Color(0xFF999999)))),
        )
      ],
    ));
  }

  Widget _taskRecording() {
    List<JoinIds> joinIds =
        item.joinIds.where((e) => (e.id == Global.userCache.id)).toList();
    return Container(
        child: Row(
      children: [
        Image.asset(
          'images/recording.png',
          fit: BoxFit.cover,
        ),
        Container(
          margin: EdgeInsets.only(left: 4.w, right: 13.w),
          padding: EdgeInsets.only(right: 14.w),
          child: Text(
            '记录人员：${joinIds.length == 1 ? joinIds[0].name : ''}',
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
