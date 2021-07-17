import 'package:day/day.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/btn.dart';
import 'package:provider/provider.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:txgc_app/components/top_pic.dart';
import 'package:txgc_app/main.dart';
import 'package:txgc_app/model/signature.dart';
import 'package:txgc_app/provides/signature.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/card_list.dart';

class SigningPage extends StatefulWidget {
  @override
  _SigningPageState createState() => _SigningPageState();
}

class _SigningPageState extends State<SigningPage> with RouteAware {
  final List<Map> statusList = [
    {'title': '待我签认', 'color': Color(0xFF009CFF)},
    {'title': '签认完成', 'color': Color(0xFFD2D2D2)},
    {'title': '签认中断', 'color': Color(0xFFFF6565)},
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
      context.read<SignatureProvider>().getData(
            isReset: true,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 30.h),
        child: Stack(
          children: [
            TopPic('images/file-signing.png'),
            NavBack(),
            _listScroll(context)
          ],
        ),
      ),
    );
  }

  Widget _listScroll(BuildContext context) {
    final List<Signature> listData =
        context.watch<SignatureProvider>().listData;

    return CardList(
      listData,
      '暂无指派给我的文件签认',
      'images/signing-empty.png',
      getData: getData,
      statusList: statusList,
      cartTop: 325,
      operation: _operation,
    );
  }

  Widget _operation(BuildContext context, Signature item) {
    return Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Btn(
              '查看签认文件',
              Types.info,
              () {
                Global.formRecord['path'] = item.file;
                Global.formRecord['id'] = item.id;
                Global.formRecord['sign_ids'] = item.signIds;

                Application.router.navigateTo(
                    context, '/signing/view?id=${item.id}',
                    transition: TransitionType.native);
              },
              margin: EdgeInsets.only(right: 15.w),
            ),
          ],
        ));
  }

  Future getData(BuildContext context, bool isReset) async {
    await context.read<SignatureProvider>().getData(
          isReset: isReset,
        );
    return '';
  }
}
