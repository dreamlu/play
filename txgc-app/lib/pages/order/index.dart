import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/btn.dart';
import 'package:txgc_app/components/form_item.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:txgc_app/components/pos_dark_tab.dart';
import 'package:txgc_app/components/top_pic.dart';
import 'package:txgc_app/main.dart';
import 'package:txgc_app/model/order.dart';
import 'package:txgc_app/provides/order.dart';
import 'package:txgc_app/provides/user.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/card_list.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with RouteAware {
  final List<Map> statusList = [
    {'title': '进行中', 'color': Color(0xFF009CFF)},
    {'title': '已完成', 'color': Color(0xFFD2D2D2)},
    {'title': '预警', 'color': Color(0xFFFF6565)},
    {'title': '已作废', 'color': Color(0xFFA2A6FF)},
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
      context.read<OrderProvider>().getData(isReset: true, status: this.tabIdx);
    }
  }

  void onTab(int index) {
    setState(() {
      tabIdx = index;
      context.read<OrderProvider>().getData(isReset: true, status: this.tabIdx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            _topBanner(),
            PosDarkTab(onTab),
            _listScroll(context),
          ],
        ),
      ),
      floatingActionButton: tabIdx == 1
          ? InkWell(
              onTap: () {
                Application.router.navigateTo(context, '/order/mana',
                    transition: TransitionType.native);
              },
              child: Image.asset(
                'images/task-add.png',
                fit: BoxFit.contain,
              ),
            )
          : Container(),
    );
  }

  Widget _topBanner() {
    return Container(
      height: 300.h,
      child: Stack(
        children: [
          TopPic(
            'images/order-pic.png',
          ),
          NavBack(),
        ],
      ),
    );
  }

  Widget _listScroll(BuildContext context) {
    final List<Order> listData = context.watch<OrderProvider>().listData;

    return Expanded(
      child: CardList(listData, '暂无${this.tabIdx == 0 ? '指派给我' : '由我发起'}的工单',
          'images/order-empty.png',
          getData: getData, statusList: statusList, operation: _operation),
    );
  }

  Widget _operation(BuildContext context, Order item) {
    return Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          children: [
            Btn(
              '查看详情',
              Types.info,
              () {
                Global.formRecord = {};
                Global.formRecord['img'] = item.img != null
                    ? item.img
                        .map((e) => new MediaListType(
                            src: e.rawUrl, name: e.name, type: 'network'))
                        .toList()
                    : [];
                Global.formRecord['reply_img'] = item.replyImg != null
                    ? item.replyImg
                        .map((e) => new MediaListType(
                            src: e.rawUrl, name: e.name, type: 'network'))
                        .toList()
                    : [];

                Global.formRecord['content'] = item.content;
                Global.formRecord['reply_content'] = item.replyContent;
                Application.router.navigateTo(
                    context, '/order/view?tabIdx=$tabIdx',
                    transition: TransitionType.native);
              },
              margin: EdgeInsets.only(right: 15.w),
            ),
            Btn(
              '填写回执',
              Types.danger,
              () {
                Global.formRecord = {};
                Global.formRecord['id'] = item.id;

                Application.router.navigateTo(
                  context,
                  '/order/receipt?status=${item.status}',
                  transition: TransitionType.native,
                );
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: item.status % 2 == 0 && tabIdx == 0,
            ),
            Btn(
              '工单编辑',
              Types.info,
              () {
                Global.formRecord = {};
                Global.formRecord['id'] = item.id;
                Global.formRecord['name'] = item.name;
                Global.formRecord['end_time'] = item.endTime;
                Global.formRecord['end_hour'] = item.endHour.toString();
                Global.formRecord['is_sms'] = item.isSms;
                Global.formRecord['img'] = item.img
                    .map((e) => new MediaListType(
                        src: e.rawUrl, name: e.name, type: 'network'))
                    .toList();
                Global.formRecord['content'] = item.content;
                Global.formRecord['receive_name'] = item.receiveName;
                Global.formRecord['receive_id'] = item.receiveId;
                Application.router.navigateTo(
                  context,
                  '/order/mana?id=${item.id}',
                  transition: TransitionType.native,
                );
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: item.status != 1 && tabIdx == 1,
            ),
            Btn(
              '查看回执',
              Types.info,
              () {
                Global.formRecord = {};
                Global.formRecord['reply_content'] = item.replyContent;
                Global.formRecord['reply_img'] = item.replyImg != null
                    ? item.replyImg
                        .map((e) => new MediaListType(
                            src: e.rawUrl, name: e.name, type: 'network'))
                        .toList()
                    : [];
                Application.router.navigateTo(
                  context,
                  '/order/receipt?status=${item.status}',
                  transition: TransitionType.native,
                );
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: item.status == 1 && tabIdx == 0,
            ),
            Btn(
              '提醒回执',
              Types.danger,
              () {
                Global.formRecord['typ'] = '0';
                Global.formRecord['is_do'] = '1';
                Global.formRecord['kind'] = 0;
                Global.formRecord['nid'] = item.id;
                Global.formRecord['to_id'] = item.receiveId;

                context.read<UserProvider>().handleNotify();
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: item.status % 2 == 0 && tabIdx == 1,
            ),
          ],
        ));
  }

  Future getData(BuildContext context, bool isReset) async {
    await context
        .read<OrderProvider>()
        .getData(isReset: isReset, status: this.tabIdx);
    return '';
  }
}
