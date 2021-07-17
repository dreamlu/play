import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/btn.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:txgc_app/components/pos_dark_tab.dart';
import 'package:txgc_app/components/top_pic.dart';
import 'package:txgc_app/routers/application.dart';
import 'components/card_list.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final List<Map> statusList = [
    {'title': '预警', 'color': Color(0xFFFF6565)},
    {'title': '进行中', 'color': Color(0xFF009CFF)},
    {'title': '已作废', 'color': Color(0xFFA2A6FF)},
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
              'images/question-pic.png',
            ),
            NavBack(),
            PosDarkTab(onTab),
            CardList([
              {
                'title': '问题名称A',
                'project': '信号第一项目部',
                'username': '张三',
                'createDate': '2020-02-02 15:35:29',
                'status': 0,
                'number': '培训'
              },
              {
                'title': '问题名称A',
                'project': '信号第一项目部',
                'username': '张三',
                'createDate': '2020-02-02 15:35:29',
                'status': 1,
                'number': '培训'
              },
              {
                'title': '问题名称A问题名称A问题名称A',
                'project': '信号第一项目部',
                'username': '张三',
                'createDate': '2020-02-02 15:35:29',
                'status': 2,
                'number': '培训'
              },
              {
                'title': '问题名称A问题名称A问题名称A问题名称A问题名称A',
                'project': '信号第一项目部',
                'username': '张三',
                'createDate': '2020-02-02 15:35:29',
                'status': 3,
                'number': '培训'
              },
            ], '暂无指派给我的问题库克缺', 'images/order-empty.png',
                getData: getData, statusList: statusList, operation: operation),
          ],
        ),
      ),
      floatingActionButton: tabIdx == 1
          ? InkWell(
              onTap: () {
                Application.router.navigateTo(context, '/question/mana',
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

  Widget operation(BuildContext context, Map item) {
    return Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Btn(
              '查看详情',
              Types.info,
              () {
                Application.router.navigateTo(
                    context, '/question/view?tabIdx=$tabIdx',
                    transition: TransitionType.native);
              },
              margin: EdgeInsets.only(right: 15.w),
            ),
            Btn(
              '填写回执',
              Types.danger,
              () {
                Application.router.navigateTo(
                  context,
                  '/question/receipt?status=${item['status']}',
                  transition: TransitionType.native,
                );
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: item['status'] <= 1 && tabIdx == 0,
            ),
            Btn(
              '问题编辑',
              Types.info,
              () {
                Application.router.navigateTo(
                  context,
                  '/question/mana?id=1',
                  transition: TransitionType.native,
                );
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: item['status'] <= 2 && tabIdx == 1,
            ),
            Btn(
              '查看回执',
              Types.info,
              () {
                Application.router.navigateTo(
                  context,
                  '/question/receipt?status=${item['status']}',
                  transition: TransitionType.native,
                );
              },
              margin: EdgeInsets.only(right: 15.w),
              isShow: item['status'] == 3 && tabIdx == 0,
            ),
            Btn(
              '提醒回执',
              Types.danger,
              () {},
              margin: EdgeInsets.only(right: 15.w),
              isShow: item['status'] <= 1 && tabIdx == 1,
            ),
          ],
        ));
  }

  Future getData(BuildContext context, bool isReset) async {
    // context.read<AddressProvider>().getData(isReset: isReset);
    return '';
  }
}
