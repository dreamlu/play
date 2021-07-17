import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/constants/index.dart';
import 'package:txgc_app/model/client.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:txgc_app/utils/global.dart';

class MenuType {
  final String icon;
  final String name;
  final String path;
  MenuType({
    this.icon,
    this.name,
    this.path,
  });
}

class StatusDescType {
  final String name;
  final Color color;
  StatusDescType({
    this.name,
    this.color,
  });
}

final List<StatusDescType> statusDesc = [
  new StatusDescType(name: '在岗', color: Color(0xFF009155)),
  new StatusDescType(name: '出差', color: Color(0xFFFF0000)),
  new StatusDescType(name: '外出', color: Color(0xFF003465)),
  new StatusDescType(name: '请假', color: Color(0xFFFF568A)),
  new StatusDescType(name: '休假', color: Color(0xFFAF75FF)),
  new StatusDescType(name: '开会', color: Color(0xFF0072FF)),
  new StatusDescType(name: '培训', color: Color(0xFFE46336)),
  new StatusDescType(name: '值班', color: Color(0xFFE4AD36)),
  new StatusDescType(name: '下班', color: Color(0xFF21627A)),
  new StatusDescType(name: '午休', color: Color(0xFFB04C4C)),
  new StatusDescType(name: '其它', color: Color(0xFF00A396)),
];

class UserBox extends StatelessWidget {
  final Client clientDetail;
  UserBox(this.clientDetail);

  final List<MenuType> menuList = [
    new MenuType(
        icon: 'images/hub-info.png', name: '个人信息', path: '/user/setting'),
    new MenuType(
        icon: 'images/hub-status.png', name: '个人状态', path: '/user/status'),
    new MenuType(
        icon: 'images/hub-lock.png', name: '修改密码', path: '/user/password'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        Positioned(
            child: Container(
          margin: EdgeInsets.only(top: 100.h),
          child: Image.asset(
            'images/hub-pic.png',
            width: 750.w,
          ),
        )),
        Positioned(
            bottom: 0,
            child: Container(
              // height: 784.h,
              child: Image.asset(
                'images/hub-bg.png',
                width: 750.w,
              ),
            )),
        _userInfo(context),
        _menuList(context),
      ],
    ));
  }

  Widget _userInfo(BuildContext context) {
    return Positioned(
        child: Container(
      margin: EdgeInsets.only(left: 35.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 66.w,
            backgroundColor: Color(0xFF009CFF),
            backgroundImage: clientDetail.headImg != null
                ? NetworkImage('$MEDIA_PREFIX${clientDetail.headImg}')
                : AssetImage('images/avatar.png'),
          ),
          Container(
            padding: EdgeInsets.only(left: 30.w, top: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_userName(), _userRole()],
                ),
                _userPhone()
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget _userName() {
    return Container(
      margin: EdgeInsets.only(right: 14.w),
      constraints: BoxConstraints(maxWidth: 229.w),
      child: Text(
        '陈柯汶',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.black, fontSize: 42.sp),
      ),
    );
  }

  Widget _userPhone() {
    return Container(
      child: Text(
        '联系方式：15869188523',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Color(0xFF999999), fontSize: 24.sp),
      ),
    );
  }

  Widget _userRole() {
    return Container(
      width: 97.w,
      height: 40.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: statusDesc[0].color,
          borderRadius: BorderRadius.circular(20.w)),
      child: Text(
        '${statusDesc[0].name}',
        style: TextStyle(color: Colors.white, fontSize: 26.sp),
      ),
    );
  }

  Widget _menuList(BuildContext context) {
    return Positioned(
        top: 300.h,
        child: Column(
          children: menuList.map((item) => _menuItem(context, item)).toList(),
        ));
  }

  Widget _menuItem(BuildContext context, MenuType item) {
    return InkWell(
      onTap: () {
        Global.formRecord = clientDetail.toJson();
        Application.router
            .navigateTo(context, item.path, transition: TransitionType.native);
      },
      child: Container(
        width: 750.w,
        padding: EdgeInsets.symmetric(horizontal: 46.w, vertical: 34.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(item.icon),
                Container(
                  margin: EdgeInsets.only(left: 32.w),
                  child: Text(
                    item.name,
                    style: TextStyle(color: Colors.black, fontSize: 32.sp),
                  ),
                )
              ],
            ),
            Image.asset('images/right-tri.png'),
          ],
        ),
      ),
    );
  }

  // Widget _userSys(BuildContext context) {
  //   return InkWell(
  //     onTap: () {
  //       Global.formRecord = clientDetail.toJson();
  //       Application.router.navigateTo(context, '/user/setting',
  //           transition: TransitionType.native);
  //     },
  //     child: Row(
  //       children: [
  //         Text(
  //           '完善信息',
  //           style: TextStyle(color: Colors.white, fontSize: 30.sp),
  //         ),
  //         Container(
  //           margin: EdgeInsets.only(left: 14.w),
  //           child: Icon(
  //             Icons.keyboard_arrow_right,
  //             color: Colors.white,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
