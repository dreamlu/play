import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/btn.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:txgc_app/components/top_pic.dart';
import 'package:txgc_app/components/top_search.dart';
import 'package:txgc_app/main.dart';
import 'package:txgc_app/model/car.dart';
import 'package:txgc_app/provides/car.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:txgc_app/utils/confirm_dialog.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/card_list.dart';

class CarPage extends StatefulWidget {
  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> with RouteAware {
  final List<Map> statusList = [
    {'title': '正常', 'color': Color(0xFF009CFF)},
    {'title': '报修', 'color': Color(0xFFFF6565)},
  ];
  int tabIdx;

  @override
  void initState() {
    super.initState();
    tabIdx = 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 添加监听订阅
    MyApp.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    // 移除监听订阅
    MyApp.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    var bool = ModalRoute.of(context).isCurrent;
    if (bool) {
      context.read<CarProvider>().getData(
            isReset: true,
          );
    }
  }

  // Future<void> onTab(int index) async {
  //   await context.read<CarProvider>().getData(isReset: true);
  //   setState(() {
  //     tabIdx = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            TopPic(
              'images/car-pic.png',
            ),
            NavBack(),
            Positioned(
              left: 25.w,
              right: 25.w,
              top: 330.h,
              child: TopSearch(
                hintText: '根据关键字搜索车辆',
                onEditingComplete: (String keywords) {
                  handleEditingComplete(context, keywords);
                },
              ),
            ),
            _listScroll(context),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Global.formRecord = {};
          Application.router.navigateTo(context, '/car/mana',
              transition: TransitionType.native);
        },
        child: Image.asset(
          'images/task-add.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _listScroll(BuildContext context) {
    return CardList(
        context.watch<CarProvider>().listData, '暂无车辆信息', 'images/car-empty.png',
        getData: getData, statusList: statusList, operation: _operation);
  }

  Widget _operation(BuildContext context, Car item) {
    return Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          children: [
            Btn(
              '车辆编辑',
              Types.info,
              () {
                Global.formRecord = {};
                Global.formRecord = item.toJson();
                Application.router.navigateTo(
                    context, '/car/mana?id=${item.id}',
                    transition: TransitionType.native);
              },
              margin: EdgeInsets.only(right: 15.w),
            ),
            Btn(
              '车辆日志',
              Types.info,
              () {
                Global.formRecord = {};
                Global.formRecord = item.toJson();
                Application.router.navigateTo(
                  context,
                  '/car/log',
                  transition: TransitionType.native,
                );
              },
              margin: EdgeInsets.only(right: 15.w),
            ),
            Btn(
              '删除车辆',
              Types.danger,
              () {
                handleRemove(context, item);
              },
              margin: EdgeInsets.only(right: 15.w),
            ),
          ],
        ));
  }

  void handleRemove(BuildContext context, Car item) async {
    Global.formRecord['id'] = item.id;

    /// 弹框二次确认 返回[true]则表示点击确认按钮
    if (await confirmDialog(context) &&
        await context.read<CarProvider>().handleRemove()) {
      context.read<CarProvider>().getData(isReset: true);
    }
  }

  Future getData(BuildContext context, bool isReset) async {
    await context.read<CarProvider>().getData(
          isReset: isReset,
        );
    return '';
  }

  void handleEditingComplete(BuildContext context, String keywords) async {
    await context.read<CarProvider>().getData(isReset: true, key: keywords);
  }
}
