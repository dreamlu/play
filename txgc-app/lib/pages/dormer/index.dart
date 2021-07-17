import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/btn.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:txgc_app/components/pos_dark_tab.dart';
import 'package:txgc_app/components/top_pic.dart';
import 'package:txgc_app/routers/application.dart';
import 'components/card_list.dart';

class DormerPage extends StatefulWidget {
  @override
  _DormerPageState createState() => _DormerPageState();
}

class _DormerPageState extends State<DormerPage> {
  final List<Map> statusList = [
    {'title': '进行中', 'color': Color(0xFFFF6565)},
    {'title': '未开始', 'color': Color(0xFF009CFF)},
    {'title': '已完成', 'color': Color(0xFFD2D2D2)},
  ];
  int tabIdx;

  @override
  void initState() {
    super.initState();
    tabIdx = 0;
  }

  void onTab(int index) {
    setState(() {
      tabIdx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            TopPic(
              'images/dormer-pic.png',
            ),
            NavBack(),
            PosDarkTab(onTab),
            CardList([
              {
                'title': '交接任务名称A',
                'project': '信号第一项目部',
                'username': '张三',
                'createDate': '2020-02-02 15:35:29',
                'status': 0,
                'number': 'A0001'
              },
              {
                'title': '交接任务名称A',
                'project': '信号第一项目部',
                'username': '张三',
                'createDate': '2020-02-02 15:35:29',
                'status': 1,
                'number': 'A0002'
              },
              {
                'title': '交接任务名称A交接任务名称A交接任务名称A',
                'project': '信号第一项目部',
                'username': '张三',
                'createDate': '2020-02-02 15:35:29',
                'status': 2,
                'number': 'A0003'
              },
            ], '暂无指派给我的天窗施工事件', 'images/dormer-empty.png',
                getData: getData, statusList: statusList, operation: operation),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Application.router.navigateTo(context, '/dormer/mana',
              transition: TransitionType.native);
        },
        child: Image.asset(
          'images/task-add.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget operation(BuildContext context, Map item) {
    return Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Btn(
              '查看细则',
              Types.info,
              () {
                Application.router.navigateTo(
                    context, '/dormer/view?status=${item['status']}',
                    transition: TransitionType.native);
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: item['status'] == 0 || item['status'] == 2,
            ),
            Btn(
              '编辑天窗',
              Types.info,
              () {
                Application.router.navigateTo(context, '/dormer/mana?id=1',
                    transition: TransitionType.native);
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: item['status'] == 1 && tabIdx == 1,
            ),
            Btn(
              '上天窗',
              Types.warning,
              () {
                Application.router.navigateTo(
                  context,
                  '/dormer/rule?type=0',
                  transition: TransitionType.native,
                );
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: item['status'] == 1 && tabIdx == 0,
            ),
            Btn(
              '下天窗',
              Types.danger,
              () {
                Application.router.navigateTo(
                  context,
                  '/dormer/rule?type=1',
                  transition: TransitionType.native,
                );
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: item['status'] == 0 && tabIdx == 0,
            ),
            Btn(
              '撤销天窗',
              Types.danger,
              () {},
              margin: EdgeInsets.only(right: 15.w),
              isShow: item['status'] == 1 && tabIdx == 1,
            )
          ],
        ));
  }

  Future getData(BuildContext context, bool isReset) async {
    // context.read<AddressProvider>().getData(isReset: isReset);
    return '';
  }
}
