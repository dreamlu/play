import 'package:flutter/material.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/user_box.dart';

class UserStatusPage extends StatefulWidget {
  @override
  _UserStatusPageState createState() => _UserStatusPageState();
}

class _UserStatusPageState extends State<UserStatusPage> {
  int statusIdx = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TopAppBar(
        Container(
          child: _formList(context),
        ),
        '个人状态');
  }

  Widget _formList(BuildContext context) {
    return Container(
      width: 750.w,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Wrap(
          children: statusDesc
              .map((item) => _tag(context, item, statusDesc.indexOf(item)))
              .toList(),
        ),
        _formBtn(context)
      ]),
    );
  }

  Widget _tag(BuildContext context, StatusDescType item, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          statusIdx = index;
        });
      },
      child: Container(
          width: 340.w,
          height: 90.h,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 20.w, bottom: 25.h),
          decoration: BoxDecoration(
              color: index == statusIdx ? item.color : Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(10.w)),
          child: Text(item.name,
              style: TextStyle(
                  fontSize: 36.sp,
                  color:
                      index == statusIdx ? Colors.white : Color(0xFF999999)))),
    );
  }

  Widget _formBtn(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.of(context).pop();
      },
      child: Container(
        margin: EdgeInsets.only(
            bottom: (40 + Global.areaHeight).h, left: 25.w, right: 25.w),
        width: 750.w,
        height: 90.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xFF009CFF),
            boxShadow: [
              BoxShadow(
                color: Color(0x45005489),
                offset: Offset(0.0, 2.0),
                blurRadius: 5.0,
              )
            ],
            borderRadius: BorderRadius.circular(10.w)),
        child: Text(
          '确认修改',
          style: TextStyle(color: Colors.white, fontSize: 30.sp),
        ),
      ),
    );
  }
}
