import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/top_header.dart';

class MenuType {
  final String name;
  final String path;
  final String icon;
  MenuType({this.name, this.path, this.icon});
}

List<MenuType> projectMenuList = [
  new MenuType(name: '任务交接', path: '/handover', icon: 'th.png'),
  new MenuType(name: '文件签认', path: '/signing', icon: 'de.png'),
  new MenuType(name: '文件审批', path: '/approve', icon: 'da.png'),
  new MenuType(name: '影像资料收集', path: '/media', icon: 'idc.png'),
  new MenuType(name: '派工单', path: '/order', icon: 'dwo.png'),
  new MenuType(name: '车辆司机管理', path: '/travel', icon: 'vdm.png'),
  new MenuType(name: '资源共享', path: '/sharing', icon: 'Infor-sharing.png'),
  new MenuType(name: '文件接收状态确认', path: '/doc', icon: 'frsc.png'),
  new MenuType(name: '施工安全质量典型案例库', path: '/instance', icon: 'csqtcl.png'),
  new MenuType(name: '共享编辑', path: '/editor', icon: 'shared-editing.png'),
  new MenuType(name: '合同管理', path: '/contract', icon: 'cm.png'),
  new MenuType(name: '会议管理', path: '/meeting', icon: 'meeting-mana.png'),
  new MenuType(name: '维修加油上报', path: '/fuel', icon: 'mr.png'),
];

List<MenuType> engineeringMenuList = [
  new MenuType(name: '问题库克缺', path: '/question', icon: 'qcim.png'),
  new MenuType(name: '工程实名制', path: '/signing', icon: 'erns.png'),
];

List<MenuType> departmentMenuList = [
  new MenuType(name: '天窗施工管理', path: '/dormer', icon: 'scm.png'),
  new MenuType(name: '食堂考勤', path: '/canteen', icon: 'ca.png'),
  new MenuType(name: '物资管理', path: '/', icon: 'mm.png'),
  new MenuType(name: '站点信息', path: '/site', icon: 'si.png'),
];

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // menuList[0] = 87;

    super.build(context);

    return TopAppBar(
        SingleChildScrollView(
          child: Container(
            width: 750.w,
            padding: EdgeInsets.only(left: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopHeader(),
                _title('项目部办公模块'),
                _menuList(context, projectMenuList),
                _title('工程办公模块'),
                _menuList(context, engineeringMenuList),
                _title('施工项目部办公模块'),
                _menuList(context, departmentMenuList),
              ],
            ),
          ),
        ),
        '');
  }

  Widget _title(String title) {
    return Container(
      padding: EdgeInsets.only(bottom: 30.w),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black, fontSize: 30.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _menuList(BuildContext context, List<MenuType> data) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: data.map((item) => _menuItem(context, item)).toList(),
    );
  }

  Widget _menuItem(BuildContext context, MenuType item) {
    return InkWell(
      child: Container(
        width: 150.w,
        height: 230.h,
        margin: EdgeInsets.only(right: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/${item.icon}'),
            Container(
              margin: EdgeInsets.only(top: 10.h),
              child: Text(
                item.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Application.router
            .navigateTo(context, item.path, transition: TransitionType.native);
      },
    );
  }
}
