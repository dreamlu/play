import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/model/task.dart';
import 'package:txgc_app/provides/task.dart';
import 'package:txgc_app/routers/router_role.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/index.dart';
import 'components/bottom_operation.dart';
import 'components/task_file.dart';
import 'components/task_title.dart';

class HanderOverViewPage extends StatelessWidget {
  final Map<String, dynamic> params;
  HanderOverViewPage(this.params);

  @override
  Widget build(BuildContext context) {
    final List<Task> listData = context.read<TaskProvider>().listData;
    final Task task =
        listData.firstWhere((element) => element.id == int.parse(params['id']));
    return TopAppBar(
        Stack(
          children: [
            SingleChildScrollView(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _taskBody(context, task),
                  _taskPic(context, task),
                  _taskFile(context, task),
                  Container(
                    height: (130 + Global.areaHeight).h,
                  )
                ],
              ),
              constraints: BoxConstraints(
                  minHeight: (Global.fullHeight - 130 - Global.areaHeight).h),
            )),
            params['tabIdx'] == '0' &&
                    task.status == 0 &&
                    RouterRole.getRole(context).canMana
                ? BottomOperation(task)
                : Container(),
          ],
        ),
        '查看任务内容');
  }

  Widget _taskBody(BuildContext context, Task task) {
    return TaskTitle('任务内容',
        child: Container(
          child: Text('${task.content}1'),
        ));
  }

  Widget _taskPic(BuildContext context, Task task) {
    return TaskTitle('任务图片',
        child: Container(
            child: Wrap(
          children: task.img
              .map((item) => Container(
                    margin: EdgeInsets.only(
                        right: (task.img.indexOf(item) + 1) % 3 == 0 ? 0 : 18.w,
                        bottom: 18.w),
                    child: cacheImg(
                      context,
                      item.url,
                      width: 220.w,
                      height: 220.h,
                    ),
                  ))
              .toList(),
        )));
  }

  Widget _taskFile(BuildContext context, Task task) {
    return TaskTitle('任务文件', child: TaskFile(task.file ?? []));
  }
}
