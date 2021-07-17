import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/btn.dart';
import 'package:provider/provider.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:txgc_app/components/pos_dark_tab.dart';
import 'package:txgc_app/components/top_pic.dart';
import 'package:txgc_app/components/top_search.dart';
import 'package:txgc_app/main.dart';
import 'package:txgc_app/model/meeting.dart';
import 'package:txgc_app/provides/meeting.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:txgc_app/utils/confirm_dialog.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/card_list.dart';

class MeetingPage extends StatefulWidget {
  @override
  _MeetingPageState createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> with RouteAware {
  final List<Map> statusList = [
    {'title': '未开始', 'color': Color(0xFFFF6565)},
    {'title': '进行中', 'color': Color(0xFF009CFF)},
    {'title': '已结束', 'color': Color(0xFFD2D2D2)},
    {'title': '已取消', 'color': Color(0xFFA2A6FF)},
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
      context
          .read<MeetingProvider>()
          .getData(isReset: true, status: this.tabIdx);
    }
  }

  void onTab(int index) {
    context.read<MeetingProvider>().getData(isReset: true, status: index);
    setState(() {
      tabIdx = index;
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
            Container(
              margin: EdgeInsets.only(top: 20.h, left: 25.w, right: 25.w),
              child: TopSearch(
                hintText: '根据关键字搜索会议',
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
          Application.router.navigateTo(context, '/meeting/schedule',
              transition: TransitionType.native);
        },
        child: Image.asset(
          'images/task-add.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _topBanner() {
    return Container(
      height: 300.h,
      child: Stack(
        children: [
          TopPic(
            'images/metting-pic.png',
          ),
          NavBack(),
        ],
      ),
    );
  }

  Widget _listScroll(BuildContext context) {
    final List<Meeting> listData = context.watch<MeetingProvider>().listData;

    return Expanded(
      child: CardList(listData, '暂无由我参与的会议', 'images/receive-empty.png',
          getData: getData,
          statusList: statusList,
          operation: _operation,
          tabIdx: this.tabIdx),
    );
  }

  Future getData(BuildContext context, bool isReset) async {
    await context
        .read<MeetingProvider>()
        .getData(isReset: isReset, status: this.tabIdx);
    return '';
  }

  void handleEditingComplete(BuildContext context, String keywords) async {
    // await context.read<CarDriverProvider>().getData(key: keywords, isReset: true);
  }

  Widget _operation(BuildContext context, Meeting item) {
    return Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          children: [
            Btn(
              '确认收到',
              Types.info,
              () {
                Application.router.navigateTo(context, '/car/mana?id=1',
                    transition: TransitionType.native);
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: item.status == 0 && tabIdx == 0,
            ),
            Btn(
              '查看会议记录',
              Types.info,
              () {
                Application.router.navigateTo(context, '/meeting/mana?id=1',
                    transition: TransitionType.native);
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: item.status == 2,
            ),
            Btn(
              '上传会议记录',
              Types.danger,
              () {
                Application.router.navigateTo(
                  context,
                  '/meeting/mana',
                  transition: TransitionType.native,
                );
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: item.status == 2 && tabIdx == 0,
            ),
            Btn(
              '查看人员确认情况',
              Types.info,
              () async {
                Global.formRecord['join_ids'] = {};
                Global.formRecord['join_ids'] = item.joinIds ?? [];

                Application.router.navigateTo(
                  context,
                  '/meeting/confirm',
                  transition: TransitionType.native,
                );
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: item.status <= 2 && tabIdx == 1,
            ),
            Btn(
              '取消会议',
              Types.cancel,
              () async {
                await confirmDialog(context);
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: item.status == 0 && tabIdx == 1,
            ),
            Btn(
              '结束会议',
              Types.danger,
              () async {
                await confirmDialog(context);
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: item.status == 1 && tabIdx == 1,
            ),
          ],
        ));
  }
}
