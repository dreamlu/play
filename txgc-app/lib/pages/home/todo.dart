import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:txgc_app/components/refresh_footer.dart';
import 'package:txgc_app/components/refresh_header.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/pannel_item.dart';

class HomeTodoPage extends StatefulWidget {
  final Map<String, dynamic> params;
  HomeTodoPage(
    this.params,
  );
  @override
  _HomeTodoPageState createState() => _HomeTodoPageState();
}

class _HomeTodoPageState extends State<HomeTodoPage> {
  bool isEmpty = false;

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
    {
      'title': '王五指定了一个派工单给您，请及时确认',
      'status': 0,
      'statusDesc': '#已处理',
      'statusBg': Color(0xFFD2D2D2),
      'isOver': true,
      'createTime': '2021-06-13 12:00:32发布',
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
                        children: toDoList
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
      '待办事项',
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
              '暂无由我接收的待办事项/消息通知',
              style: TextStyle(color: Color(0xFFADBBCA), fontSize: 28.sp),
            ),
          ),
          Container(
            width: 204.w,
            height: 65.h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 41.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.w),
                color: Color(0xFF009CFF),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 2.w),
                      blurRadius: 5.w,
                      color: Color(0x45005489))
                ]),
            child: Text(
              '查看已完成',
              style: TextStyle(color: Colors.white, fontSize: 28.sp),
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
