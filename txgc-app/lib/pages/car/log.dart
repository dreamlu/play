import 'package:flutter/material.dart';
import 'package:txgc_app/components/dark_tab.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:txgc_app/model/car_log.dart';
import 'package:txgc_app/pages/car/components/log_list.dart';
import 'package:txgc_app/provides/car_log.dart';
import 'package:txgc_app/utils/global.dart';

class CarLogPage extends StatefulWidget {
  final Map<String, dynamic> params;

  CarLogPage(this.params);

  @override
  _CarLogPageState createState() => _CarLogPageState();
}

class _CarLogPageState extends State<CarLogPage> {
  int tabIdx = 0;
  List tabList = [
    {'label': '所在工程信息', 'value': 0},
    {'label': '所在司机信息', 'value': 1}
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TopAppBar(
      Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Color(0xFF009CFF),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [DarkTab(this.tabList, onTap), _listScroll(context)],
        ),
      ),
      '车辆日志',
    );
  }

  Widget _listScroll(BuildContext context) {
    final List<CarLog> listData = context.watch<CarLogProvider>().listData;

    return Expanded(
      child: LogList(listData, '暂无日志信息', this.tabIdx, getData: getData),
    );
  }

  void onTap(int tabIdx) async {
    await context.read<CarLogProvider>().getData(
          isReset: true,
          plate: Global.formRecord['plate'],
          typ: this.tabIdx,
        );
    setState(() {
      this.tabIdx = tabIdx;
    });
  }

  Future getData(BuildContext context, bool isReset) async {
    await context.read<CarLogProvider>().getData(
          isReset: isReset,
          plate: Global.formRecord['plate'],
          typ: this.tabIdx,
        );
    return '';
  }
}
