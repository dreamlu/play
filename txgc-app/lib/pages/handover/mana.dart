import 'dart:async';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/main.dart';
import 'package:txgc_app/model/media.dart';
import 'package:txgc_app/provides/task.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/mana_form_item.dart';
import 'components/task_file.dart';
import 'components/task_title.dart';

class HanderOverManaPage extends StatefulWidget {
  final Map<String, dynamic> params;
  HanderOverManaPage(this.params);
  @override
  _HanderOverManaPageState createState() => _HanderOverManaPageState();
}

class _HanderOverManaPageState extends State<HanderOverManaPage>
    with RouteAware {
  GlobalKey<FormState> _formKey;

  List<Media> files;

  @override
  void initState() {
    super.initState();
    files = Global.formRecord['file'] ?? [];
    _formKey = new GlobalKey<FormState>();
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
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return TopAppBar(
        Container(
          child: SingleChildScrollView(
            child: _formList(),
          ),
        ),
        widget.params['id'] == null ? '新增任务交接' : '编辑任务交接');
  }

  Widget _formList() {
    return Form(
      key: _formKey,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Wrap(
          children: [
            ManaFormItem('name', "任务名称", "请输入新增任务的名称", isClear: true),
            ManaFormItem(
              'receive_name',
              "任务接收人员",
              "从项目部选择人员 ›",
              isCustPicker: true,
              onPicker: () {
                Application.router.navigateTo(context, '/handover/project',
                    transition: TransitionType.native);
              },
              value: Global.formRecord['receive_name'],
            ),
            ManaFormItem(
              'content',
              "任务内容",
              """请填写任务交接的详情内容，可填写内容：\n1.任务已完成部分；\n2.任务未完成部分；\n3.需要接收人完成的任务细则；""",
              keyboardType: TextInputType.multiline,
              minLines: 8,
            ),
            Container(
              height: 15.h,
              color: Color(0xfff7f7f7),
              margin: EdgeInsets.only(bottom: 39.h),
            ),
            ManaFormItem('img', "任务图片", "请上传任务图片", isMedia: true),
            widget.params['id'] == null ? Container() : _taskFile(context)
          ],
        ),
        _formBtn(context)
      ]),
    );
  }

  Widget _taskFile(BuildContext context) {
    return TaskTitle(
      '任务文件',
      child: TaskFile(
        files,
        isView: false,
        onTap: (Media item) {
          setState(() {
            files = files.where((element) => element != item).toList();
            Global.formRecord['file'] = files;
          });
        },
      ),
    );
  }

  Widget _formBtn(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          //验证通过提交数据
          _formKey.currentState.save();
          if (widget.params['id'] == null) {
            if (await context.read<TaskProvider>().handleCreate()) {
              Timer(Duration(seconds: 1), () {
                Navigator.of(context).pop();
              });
            }
          } else {
            if (await context.read<TaskProvider>().handleUpdate()) {
              Timer(Duration(seconds: 1), () {
                Navigator.of(context).pop();
              });
            }
          }
        }
      },
      child: Container(
        margin: EdgeInsets.only(
            top: 45.h,
            bottom: (35 + Global.areaHeight).h,
            left: 25.w,
            right: 25.w),
        width: 750.w,
        height: 90.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xFF009CFF),
            boxShadow: [
              BoxShadow(
                color: Color(0x45005489),
                offset: Offset(0.0, 2.0),
                blurRadius: 5.0,
              )
            ],
            borderRadius: BorderRadius.circular(10.w)),
        child: Text(
          widget.params['id'] == null ? '确认发布' : '确认修改',
          style: TextStyle(color: Colors.white, fontSize: 28.sp),
        ),
      ),
    );
  }
}
