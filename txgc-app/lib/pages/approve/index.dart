import 'package:day/day.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/btn.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:txgc_app/components/top_pic.dart';
import 'package:txgc_app/main.dart';
import 'package:txgc_app/model/approve.dart';
import 'package:txgc_app/provides/approve.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/card_list.dart';

class ApprovePage extends StatefulWidget {
  @override
  _ApprovePageState createState() => _ApprovePageState();
}

class _ApprovePageState extends State<ApprovePage> with RouteAware {
  final List<Map> statusList = [
    {'title': '待我审批', 'color': Color(0xFF009CFF)},
    {'title': '审批结束', 'color': Color(0xFFD2D2D2)},
    {'title': '审批中断', 'color': Color(0xFFFF6565)},
  ];

  @override
  void initState() {
    super.initState();
    Global.formRecord['timestamp'] = Day().millisecond();
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
      context.read<ApproveProvider>().getData(
            isReset: true,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [_topBanner(), _listScroll(context)],
        ),
      ),
    );
  }

  Widget _topBanner() {
    return Container(
      height: 300.h,
      child: Stack(
        children: [
          TopPic('images/file-approve.png'),
          NavBack(),
        ],
      ),
    );
  }

  Widget _listScroll(BuildContext context) {
    final List<Approve> listData = context.watch<ApproveProvider>().listData;

    return Expanded(
      child: CardList(
        listData,
        '暂无指派给我的文件审批',
        'images/signing-empty.png',
        getData: getData,
        statusList: statusList,
        operation: _operation,
      ),
    );
  }

  Widget _operation(BuildContext context, Approve item) {
    return Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Btn(
              '查看审批文件',
              Types.info,
              () {
                Global.formRecord['path'] = item.file;
                Global.formRecord['id'] = item.id;
                Global.formRecord['sign_ids'] = item.signIds;

                Application.router.navigateTo(
                    context, '/approve/view?id=${item.id}',
                    transition: TransitionType.native);
              },
              margin: EdgeInsets.only(right: 15.w),
            ),
          ],
        ));
  }

  Future getData(BuildContext context, bool isReset) async {
    await context.read<ApproveProvider>().getData(
          isReset: isReset,
        );
    return '';
  }
}
