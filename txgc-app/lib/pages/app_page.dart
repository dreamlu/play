import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:txgc_app/components/lazy_indexed_stack.dart';
import 'package:txgc_app/pages/dashboard/index.dart';
import 'package:txgc_app/pages/home/index.dart';
import 'package:txgc_app/pages/user/index.dart';
import 'package:txgc_app/provides/menu.dart';
import 'package:txgc_app/utils/global.dart';

class AppPage extends StatefulWidget {
  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        icon: Image.asset('images/msg.png'),
        activeIcon: Image.asset('images/msg-active.png'),
        label: '消息/待办'),
    BottomNavigationBarItem(
        icon: Image.asset('images/dashboard.png'),
        activeIcon: Image.asset('images/dashboard-active.png'),
        label: '办事大厅'),
    BottomNavigationBarItem(
        icon: Image.asset('images/hub.png'),
        activeIcon: Image.asset('images/hub-active.png'),
        label: '个人中心'),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    DashboardPage(),
    UserHomePage(),
  ];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mq = MediaQuery.of(context);
    // 屏幕密度
    final double pixelRatio = mq.devicePixelRatio;
    // 底部安全区域
    final double areaHeight = mq.padding.bottom * pixelRatio;
    final double fullHeight = mq.size.height * pixelRatio;
    // 顶部状态栏, 随着刘海屏会增高
    final double statusBarHeight = mq.padding.top * pixelRatio;

    Global.areaHeight = areaHeight;

    Global.pixelRatio = pixelRatio;

    Global.fullHeight = fullHeight;

    Global.statusBarHeight = statusBarHeight;

    return Consumer<MenuProvider>(builder: (context, _, __) {
      int menuIdx = context.watch<MenuProvider>().menuIdx;
      return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        bottomNavigationBar: BottomNavigationBar(
          items: bottomTabs,
          type: BottomNavigationBarType.fixed,
          currentIndex: menuIdx,
          onTap: (index) {
            context.read<MenuProvider>().handleMenu(index);
          },
        ),
        body: LazyIndexedStack(
          index: menuIdx,
          children: tabBodies,
        ),
      );
    });
  }
}
