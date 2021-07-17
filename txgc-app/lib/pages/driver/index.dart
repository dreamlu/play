import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/btn.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:txgc_app/components/top_pic.dart';
import 'package:txgc_app/components/top_search.dart';
import 'package:txgc_app/main.dart';
import 'package:txgc_app/model/car_driver.dart';
import 'package:txgc_app/provides/car_driver.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:txgc_app/utils/confirm_dialog.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/card_list.dart';
import 'package:provider/provider.dart';

class DriverPage extends StatefulWidget {
  @override
  _DriverPageState createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> with RouteAware {
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
      context.read<CarDriverProvider>().getData(
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
              'images/driver-pic.png',
            ),
            NavBack(),
            Positioned(
              left: 25.w,
              right: 25.w,
              top: 330.h,
              child: TopSearch(
                hintText: '根据关键字搜索司机',
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
          Application.router.navigateTo(context, '/driver/mana',
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
    return CardList(context.watch<CarDriverProvider>().listData, '暂无司机信息',
        'images/driver-empty.png',
        getData: getData, operation: _operation);
  }

  Widget _operation(BuildContext context, CarDriver item) {
    return Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          children: [
            Btn(
              '司机编辑',
              Types.info,
              () {
                Global.formRecord = {};
                Global.formRecord = item.toJson();
                Application.router.navigateTo(context, '/driver/mana?id=${item.id}',
                    transition: TransitionType.native);
              },
              margin: EdgeInsets.only(right: 15.w),
            ),
            Btn(
              '删除司机',
              Types.danger,
              () async {
                handleRemove(context, item);
              },
              margin: EdgeInsets.only(right: 15.w),
            ),
          ],
        ));
  }

  void handleRemove(BuildContext context, CarDriver item) async {
    Global.formRecord['id'] = item.id;

    /// 弹框二次确认 返回[true]则表示点击确认按钮
    if (await confirmDialog(context) &&
        await context.read<CarDriverProvider>().handleRemove()) {
      context.read<CarDriverProvider>().getData(isReset: true);
    }
  }

  Future getData(BuildContext context, bool isReset) async {
    context.read<CarDriverProvider>().getData(isReset: isReset);
    return '';
  }

  void handleEditingComplete(BuildContext context, String keywords) async {
    await context.read<CarDriverProvider>().getData(key: keywords, isReset: true);
  }
}
