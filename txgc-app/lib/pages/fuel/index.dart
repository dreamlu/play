import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:txgc_app/components/top_pic.dart';
import 'package:txgc_app/provides/car_record.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:txgc_app/utils/global.dart';
import '../../main.dart';
import 'components/card_list.dart';
import 'package:provider/provider.dart';

class FuelPage extends StatefulWidget {
  @override
  _FuelPageState createState() => _FuelPageState();
}

class _FuelPageState extends State<FuelPage> with RouteAware {
  final List<Map> statusList = [
    {'title': '正常', 'color': Color(0xFF009CFF)},
    {'title': '加油', 'color': Color(0xFFFF6565)},
  ];

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
      context.read<CarRecordProvider>().getData(
            isReset: true,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            TopPic(
              'images/fuel-pic.png',
            ),
            NavBack(),
            _listScroll(context),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Global.formRecord = {};
          Application.router.navigateTo(context, '/fuel/mana',
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
    return CardList(context.watch<CarRecordProvider>().listData, '暂无维修加油信息', 'images/driver-empty.png',
        getData: getData, statusList: statusList);
  }

  Future getData(BuildContext context, bool isReset) async {
    context.read<CarRecordProvider>().getData(isReset: isReset);
    return '';
  }
}
