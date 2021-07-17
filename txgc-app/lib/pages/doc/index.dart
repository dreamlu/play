import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/btn.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:txgc_app/components/pos_dark_tab.dart';
import 'package:txgc_app/components/top_pic.dart';
import 'package:txgc_app/model/file_receive.dart';
import 'package:txgc_app/provides/file_receive.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:txgc_app/utils/global.dart';
import '../../main.dart';
import 'components/card_list.dart';
import 'package:provider/provider.dart';

class DocPage extends StatefulWidget {
  @override
  _DocPageState createState() => _DocPageState();
}

class _DocPageState extends State<DocPage> with RouteAware {
  final List<Map> statusRecList = [
    {'title': '未浏览', 'color': Color(0xFFFF6565)},
    {'title': '浏览完毕', 'color': Color(0xFFD2D2D2)},
    {'title': '浏览未确认', 'color': Color(0xFF009CFF)},
  ];
  final List<Map> statusList = [
    {'title': '进行中', 'color': Color(0xFF009CFF)},
    {'title': '进行中', 'color': Color(0xFF009CFF)},
    {'title': '已结束', 'color': Color(0xFFD2D2D2)},
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
          .read<FileReceiveProvider>()
          .getData(isReset: true, status: this.tabIdx);
    }
  }

  void onTab(int index) {
    context.read<FileReceiveProvider>().getData(isReset: true, status: index);
    setState(() {
      tabIdx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 30.h),
        child: Column(
          children: [
            _topBanner(),
            PosDarkTab(onTab),
            _listScroll(context),
          ],
        ),
      ),
    );
  }

  Widget _listScroll(BuildContext context) {
    final List<FileReceive> listData =
        context.watch<FileReceiveProvider>().listData;

    return Expanded(
      child: CardList(listData, '暂无由我${tabIdx == 0 ? '接收' : '发起'}的文件接收',
          'images/receive-empty.png',
          getData: getData,
          statusList: tabIdx == 0 ? statusRecList : statusList,
          operation: _operation,
          tabIdx: tabIdx),
    );
  }

  Widget _topBanner() {
    return Container(
      height: 300.h,
      child: Stack(
        children: [
          TopPic(
            'images/receive-pic.png',
          ),
          NavBack(),
        ],
      ),
    );
  }

  Widget _operation(BuildContext context, FileReceive item) {
    return Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          children: [
            Btn(
              '查看文件',
              Types.info,
              () {
                Global.formRecord = {};
                Global.formRecord['id'] = item.id;
                Global.formRecord['file'] = item.file;
                Global.formRecord['receive_ids'] = item.receiveIds;

                Application.router.navigateTo(
                    context, '/doc/view?tabIdx=$tabIdx',
                    transition: TransitionType.native);
              },
              margin: EdgeInsets.only(right: 15.w),
            ),
            Btn(
              '查看浏览情况',
              Types.info,
              () {
                Global.formRecord['receive_ids'] = item.receiveIds;
                Application.router.navigateTo(
                  context,
                  '/doc/browse?id=${item.id}',
                  transition: TransitionType.native,
                );
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: tabIdx == 1,
            ),
          ],
        ));
  }

  Future getData(BuildContext context, bool isReset) async {
    await context
        .read<FileReceiveProvider>()
        .getData(isReset: isReset, status: this.tabIdx);
    return '';
  }
}
