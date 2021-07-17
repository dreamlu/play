import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/btn.dart';
import 'package:txgc_app/components/form_item.dart';
import 'package:txgc_app/components/modal.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:txgc_app/components/pos_dark_tab.dart';
import 'package:txgc_app/components/top_pic.dart';
import 'package:txgc_app/main.dart';
import 'package:txgc_app/model/task.dart';
import 'package:txgc_app/provides/task.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:txgc_app/routers/router_role.dart';
import 'package:txgc_app/utils/confirm_dialog.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/card_list.dart';

class HanderOverPage extends StatefulWidget {
  @override
  _HanderOverPageState createState() => _HanderOverPageState();
}

class _HanderOverPageState extends State<HanderOverPage> with RouteAware {
  int tabIdx;
  final List<Map> statusList = [
    {'title': '交接中', 'color': Color(0xFF009CFF)},
    {'title': '已同意', 'color': Color(0xFF00C86C)},
    {'title': '已拒绝', 'color': Color(0xFFFF6565)},
  ];

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
      context.read<TaskProvider>().getData(isReset: true, status: this.tabIdx);
    }
  }

  void handleTab(int tabIdx) async {
    await context.read<TaskProvider>().getData(isReset: true, status: tabIdx);
    setState(() {
      this.tabIdx = tabIdx;
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
            PosDarkTab(handleTab),
            _listScroll(context),
          ],
        ),
      ),
      floatingActionButton: RouterRole.getRole(context).canMana
          ? InkWell(
              onTap: () {
                Application.router.navigateTo(context, '/handover/mana',
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
            'images/task-handover.png',
          ),
          NavBack(),
        ],
      ),
    );
  }

  Widget _listScroll(BuildContext context) {
    final List<Task> listData = context.watch<TaskProvider>().listData;

    return Expanded(
      child: CardList(listData, '暂无由我${tabIdx == 0 ? '接收' : '发起'}的任务交接',
          'images/task-empty.png',
          getData: getData, statusList: statusList, operation: _operation),
    );
  }

  void handleAgree(BuildContext context, Task task) async {
    Global.formRecord['id'] = task.id;
    Global.formRecord['status'] = 1;
    if (await context.read<TaskProvider>().handleStatus()) {
      context.read<TaskProvider>().getData(isReset: true, status: this.tabIdx);
    }
  }

  void handleReject(BuildContext context, Task task) async {
    Global.formRecord['id'] = task.id;
    Global.formRecord['status'] = 2;
    await globalModal(context,
        formKey: 'reason',
        title: '拒绝接收',
        titleColor: Color(0xFFFF6565),
        keyboardType: TextInputType.text,
        hintText: '点击输入拒绝理由',
        cancelTitle: '取消填写',
        cancelBgColor: Color(0xFFD2D2D2),
        okTitle: '确认提交',
        okBgColor: Color(0xFFFF6565),
        maxLines: 5);
    if (await context.read<TaskProvider>().handleStatus()) {
      context.read<TaskProvider>().getData(isReset: true, status: this.tabIdx);
    }
  }

  void handleRemove(BuildContext context, Task task) async {
    Global.formRecord['id'] = task.id;

    /// 弹框二次确认 返回[true]则表示点击确认按钮
    if (await confirmDialog(context) &&
        await context.read<TaskProvider>().handleRemove()) {
      context.read<TaskProvider>().getData(isReset: true, status: this.tabIdx);
    }
  }

  Widget _operation(BuildContext context, Task item) {
    return RouterRole.getRole(context).canMana
        ? Container(
            margin: EdgeInsets.only(top: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Btn(
                  '查看任务内容',
                  Types.info,
                  () {
                    Application.router.navigateTo(
                        context, '/handover/view?id=${item.id}&tabIdx=$tabIdx',
                        transition: TransitionType.native);
                  },
                  margin: EdgeInsets.only(right: 15.w),
                ),
                Btn(
                  '编辑任务',
                  Types.info,
                  () {
                    Global.formRecord['id'] = item.id;
                    Global.formRecord['name'] = item.name;
                    Global.formRecord['img'] = item.img
                        .map((e) => new MediaListType(
                            src: e.rawUrl, name: e.name, type: 'network'))
                        .toList();

                    Global.formRecord['file'] = item.file;
                    Global.formRecord['content'] = item.content;
                    Global.formRecord['receive_name'] = item.receiveName;
                    Global.formRecord['receive_id'] = item.receiveId;

                    Application.router.navigateTo(
                        context, '/handover/mana?id=${item.id}',
                        transition: TransitionType.native);
                  },
                  margin: EdgeInsets.only(right: 15.w),
                  isShow: item.status == 0 && tabIdx == 1,
                ),
                Btn(
                  '确认接收',
                  Types.confirm,
                  () {
                    handleAgree(context, item);
                  },
                  margin: EdgeInsets.only(right: 15.w),
                  isShow: item.status == 0 && tabIdx == 0,
                ),
                Btn(
                  '拒绝接收',
                  Types.danger,
                  () {
                    handleReject(context, item);
                  },
                  margin: EdgeInsets.only(right: 15.w),
                  isShow: item.status == 0 && tabIdx == 0,
                ),
                Btn(
                  '删除任务',
                  Types.danger,
                  () {
                    handleRemove(context, item);
                  },
                  margin: EdgeInsets.only(right: 15.w),
                  isShow: item.status == 0 && tabIdx == 1,
                ),
              ],
            ))
        : Container();
  }

  Future getData(BuildContext context, bool isReset) async {
    await context
        .read<TaskProvider>()
        .getData(isReset: isReset, status: this.tabIdx);
    return '';
  }
}
