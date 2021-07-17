import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/model/car_record.dart';

class CardItem extends StatelessWidget {
  final List<Map> statusList;
  final CarRecord item;

  CardItem(
    this.item,
    this.statusList,
  );

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
        _taskProject('images/project.png', '当前所在工程：${item.engine}'),
        _taskProject('images/car.png', '车辆类型：${item.carType}'),
        _taskProject('images/address.png', '上报地点：${item.address}'),
        _taskProject('images/unit.png', '上报金额：${item.money}元'),
        _taskPic()
      ],
    );
  }

  Widget _taskPic() {
    return item.imgUrl.length != 0
        ? Container(
            width: 700.w,
            height: 110.h,
            margin: EdgeInsets.only(top: 25.h),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: item.imgUrl
                  .map<Widget>((element) => Container(
                        height: 110.h,
                        margin: EdgeInsets.only(right: 10.w),
                        child: Image.network(
                          element.url,
                          fit: BoxFit.cover,
                        ),
                      ))
                  .toList(),
            ))
        : Container();
  }

  Widget _taskTitle() {
    return Container(
      width: 700.w,
      child: Stack(
        children: [
          _taskStatus(
              statusList[item.typ]['title'], statusList[item.typ]['color']),
          Container(
            width: 600.w,
            padding: EdgeInsets.only(top: 30.h),
            child: Text(
              item.plate,
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
