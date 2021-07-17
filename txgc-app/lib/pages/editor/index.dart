import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/btn.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:txgc_app/components/pos_dark_tab.dart';
import 'package:txgc_app/components/top_pic.dart';
import 'package:txgc_app/main.dart';
import 'package:txgc_app/model/share_edit.dart';
import 'package:txgc_app/provides/share_edit.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:txgc_app/utils/confirm_dialog.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/card_list.dart';

class EditorPage extends StatefulWidget {
  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> with RouteAware {
  final List<Map> statusList = [
    {'title': '未提交', 'color': Color(0xFFFF6565)},
    {'title': '已提交', 'color': Color(0xFF009CFF)},
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
          .read<ShareEditProvider>()
          .getData(isReset: true, status: this.tabIdx);
    }
  }

  void onTab(int index) {
    context.read<ShareEditProvider>().getData(isReset: true, status: index);

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
            _listScroll(context),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Application.router.navigateTo(context, '/editor/mana',
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
            'images/editor-pic.png',
          ),
          NavBack(),
        ],
      ),
    );
  }

  Widget _listScroll(BuildContext context) {
    final List<ShareEdit> listData =
        context.watch<ShareEditProvider>().listData;

    return Expanded(
      child: CardList(listData, '暂无指派给我的共享编辑', 'images/signing-empty.png',
          getData: getData,
          statusList: statusList,
          tabIdx: tabIdx,
          operation: _operation),
    );
  }

  void handleRemove(BuildContext context, ShareEdit task) async {
    Global.formRecord['id'] = task.id;

    /// 弹框二次确认 返回[true]则表示点击确认按钮
    if (await confirmDialog(context) &&
        await context.read<ShareEditProvider>().handleRemove()) {
      context
          .read<ShareEditProvider>()
          .getData(isReset: true, status: this.tabIdx);
    }
  }

  Widget _operation(BuildContext context, ShareEdit item) {
    return Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          children: [
            Btn(
              '提交共享编辑',
              Types.info,
              () {
                Global.formRecord = {};
                Global.formRecord['name'] = item.name;
                Global.formRecord['view_content'] = item.content;
                Global.formRecord['id'] = item.id;
                Global.formRecord['is_ay'] = item.isAy;
                Global.formRecord['receive_ids'] = item.receiveIds;
                Global.formRecord['receive_id_log'] = item.receiveIdLog;

                Application.router.navigateTo(context,
                    '/editor/view?isPublic=${item.isPublic}&id=${item.id}&isView=false',
                    transition: TransitionType.native);
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: tabIdx == 0,
            ),
            Btn(
              '查看共享编辑',
              Types.info,
              () {
                Global.formRecord['name'] = item.name;
                Global.formRecord['view_content'] = item.content;
                Global.formRecord['is_ay'] = item.isAy;
                Global.formRecord['receive_ids'] = item.receiveIds;
                Global.formRecord['receive_id_log'] = item.receiveIdLog;
                Application.router.navigateTo(context,
                    '/editor/view?isPublic=${item.isPublic}}&id=1&isView=true',
                    transition: TransitionType.native);
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: tabIdx == 1,
            ),
            Btn(
              '删除',
              Types.danger,
              () {
                handleRemove(context, item);
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: tabIdx == 1,
            ),
          ],
        ));
  }

  Future getData(BuildContext context, bool isReset) async {
    await context
        .read<ShareEditProvider>()
        .getData(isReset: isReset, status: this.tabIdx);
    return '';
  }
}
