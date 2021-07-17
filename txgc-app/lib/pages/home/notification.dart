import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:txgc_app/components/refresh_footer.dart';
import 'package:txgc_app/components/refresh_header.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/pannel_item.dart';

class HomeNotificationPage extends StatefulWidget {
  final Map<String, dynamic> params;
  HomeNotificationPage(
    this.params,
  );
  @override
  _HomeNotificationPageState createState() => _HomeNotificationPageState();
}

class _HomeNotificationPageState extends State<HomeNotificationPage> {
  bool isEmpty = false;

  List<Map> notificationList = [
    {
      'title': '张三提醒您及时完成派工单',
      'status': 1,
      'statusDesc': '#即将截止',
      'statusBg': Color(0xFFFF4545),
      'createTime': '2021-06-13 12:00:32提示您',
    },
    {
      'title': '张三提醒您及时完成问题库克缺',
      'status': 1,
      'statusDesc': '#即将截止',
      'statusBg': Color(0xFFFF4545),
      'createTime': '2021-06-13 12:00:32提示您',
    },
    {
      'title': '张三提醒您参与会议',
      'status': 0,
      'statusDesc': '#未处理',
      'statusBg': Color(0xFFFF9D45),
      'createTime': '2021-06-13 12:00:32提示您',
    },
    {
      'title': '王五提醒您及时完成天窗施工管理',
      'status': 0,
      'statusDesc': '#已读',
      'statusBg': Color(0xFFD2D2D2),
      'isOver': true,
      'createTime': '2021-06-13 12:00:32提示您',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return TopAppBar(
      Container(
          padding: EdgeInsets.all(25.h),
          color: Color(0xFFF7F7F7),
          child: isEmpty
              ? _empty()
              : EasyRefresh(
                  header: RefreshHeader(),
                  footer: RefreshFooter(),
                  child: Container(
                    child: Wrap(
                        children: notificationList
                            .map(
                              (item) => PannelItem(
                                  statusDesc: item['statusDesc'],
                                  statusBg: item['statusBg'],
                                  createTime: item['createTime'],
                                  content: item['title'],
                                  isOver: item['isOver'] ?? false,
                                  onTap: () {}),
                            )
                            .toList()),
                  ),
                  onRefresh: () async {
                    getData(context);
                  })),
      '消息通知',
    );
  }

  Widget _empty() {
    return Container(
      width: 750.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/msg-empty.png',
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.only(top: 55.h),
            child: Text(
              '暂无由我接收的消息通知',
              style: TextStyle(color: Color(0xFFADBBCA), fontSize: 28.sp),
            ),
          ),
        ],
      ),
    );
  }

  void getData(BuildContext context) async {
    // var res = await request('getGoodDetailById', 'post');
    print('start');
    // print(res);
    print('end');
  }
}
