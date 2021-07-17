import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/provides/user.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:provider/provider.dart';
import 'components/pannel_item.dart';
import 'components/pannel_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<Map> toDoList = [
    {
      'title': '张三指定了一个任务交接给您，请及时确认',
      'status': 0,
      'statusDesc': '#未处理',
      'statusBg': Color(0xFFFF9D45),
      'createTime': '2021-06-13 12:00:32发布',
    },
    {
      'title': '李四指定了一个问题库克缺给您，请及时确认',
      'status': 0,
      'statusDesc': '#未处理',
      'statusBg': Color(0xFFFF9D45),
      'createTime': '2021-06-13 12:00:32发布',
    },
    {
      'title': '王五指定了一个派工单给您，请及时确认',
      'status': 0,
      'statusDesc': '#未处理',
      'statusBg': Color(0xFFFF9D45),
      'createTime': '2021-06-13 12:00:32发布',
    },
  ];

  List<Map> notificationList = [
    {
      'title': '张三提醒您及时完成派工单',
      'status': 1,
      'statusDesc': '#未读',
      'statusBg': Color(0xFFFF9D45),
      'createTime': '2021-06-13 12:00:32提示您',
    },
    {
      'title': '张三提醒您及时完成问题库克缺',
      'status': 1,
      'statusDesc': '#未读',
      'statusBg': Color(0xFFFF9D45),
      'createTime': '2021-06-13 12:00:32提示您',
    },
    {
      'title': '张三提醒您参与会议',
      'status': 0,
      'statusDesc': '#未读',
      'statusBg': Color(0xFFFF9D45),
      'createTime': '2021-06-13 12:00:32提示您',
    },
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    context.read<UserProvider>().getAuthentication(context);

    return TopAppBar(
      Container(
        padding: EdgeInsets.all(25.h),
        color: Color(0xFFF7F7F7),
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              PannelList(
                title: '待办事项',
                icon: 'images/to-do.png',
                data: toDoList
                    .map(
                      (item) => PannelItem(
                          statusDesc: item['statusDesc'],
                          statusBg: item['statusBg'],
                          createTime: item['createTime'],
                          content: item['title'],
                          onTap: () {}),
                    )
                    .toList(),
                navPath: '/todo',
              ),
              PannelList(
                title: '消息通知',
                icon: 'images/notification.png',
                data: notificationList
                    .map(
                      (item) => PannelItem(
                          statusDesc: item['statusDesc'],
                          statusBg: item['statusBg'],
                          createTime: item['createTime'],
                          content: item['title'],
                          onTap: () {}),
                    )
                    .toList(),
                navPath: '/notification',
              ),
            ],
          ),
        ),
      ),
      '待办事项/消息通知',
      actions: [
        InkWell(
          onTap: () {
            Application.router.navigateTo(context, '/scan',
                transition: TransitionType.native);
          },
          child: Image.asset('images/scan.png'),
        )
      ],
    );
  }
}
