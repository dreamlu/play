import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/form_checkbox.dart';
import 'package:txgc_app/components/hr.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/main.dart';
import 'package:txgc_app/provides/order.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/index.dart';
import 'components/order_form_item.dart';

class OrderManaPage extends StatefulWidget {
  final Map<String, dynamic> params;
  OrderManaPage(this.params);
  @override
  _OrderManaPageState createState() => _OrderManaPageState();
}

class _OrderManaPageState extends State<OrderManaPage> with RouteAware {
  GlobalKey<FormState> _formKey;
  List<CheckBoxType> checkList;

  @override
  void initState() {
    _formKey = new GlobalKey<FormState>();
    checkList = [
      new CheckBoxType('APP消息提醒', false, 'is_app'),
      new CheckBoxType(
          '手机短信提醒', Global.formRecord['is_sms'] ?? false, 'is_sms'),
    ];
    super.initState();
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
      widget.params["id"] == null ? '发起工单' : '编辑工单',
    );
  }

  Widget _formList() {
    return Form(
      key: _formKey,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          constraints: BoxConstraints(
              minHeight: (Global.fullHeight - Global.areaHeight - 322).h),
          child: Wrap(
            children: [
              OrderFormItem('name', "工单名称", "请输入工单名称", isClear: true),
              OrderFormItem('receive_name', "工单负责人", "从项目部选择人员 ›",
                  isCustPicker: true, onPicker: () {
                Application.router.navigateTo(context, '/handover/project',
                    transition: TransitionType.native);
              }, value: Global.formRecord['receive_name']),
              OrderFormItem(
                'end_time',
                "工单截止时间",
                "选择截止时间 ›",
                isCustPicker: true,
                onPicker: () {
                  handleDatePickerModal(context);
                },
                value: Global.formRecord['end_time'],
              ),
              Hr(margin: EdgeInsets.only(bottom: 40.h)),
              OrderFormItem(
                'end_hour',
                "工单自动提醒",
                "请输入",
                prefix: Container(
                  padding: EdgeInsets.only(right: 24.w, top: 20.w),
                  child: Text(
                    '工单截止时间',
                    style: TextStyle(color: Colors.black, fontSize: 28.sp),
                  ),
                ),
                suffix: Container(
                  padding: EdgeInsets.only(left: 30.w, top: 20.w),
                  child: Text(
                    '(小时)提醒工单负责人',
                    style: TextStyle(color: Colors.black, fontSize: 28.sp),
                  ),
                ),
              ),
              FormCheckBox(
                '工单提醒方式',
                checkList,
                single: true,
              ),
              Hr(margin: EdgeInsets.only(bottom: 40.h)),
              OrderFormItem(
                'content',
                "工单内容",
                "填写工单回执内容详情，可填写内容：\n1.工单需要完成内容。",
                minLines: 5,
                keyboardType: TextInputType.multiline,
              ),
              OrderFormItem(
                'img',
                "工单图片",
                "",
                isMedia: true,
              ),
            ],
          ),
        ),
        _formBtn(context)
      ]),
    );
  }

  /// 选择时间
  void handleDatePickerModal(BuildContext context) {
    showDatePickerModal(context, onConfirm: (Picker picker, List value) {
      Global.formRecord['end_time'] = picker.adapter.text.substring(0, 19);
      setState(() {});
    }, onSelect: (Picker picker, int index, List<int> selecteds) {});
  }

  Widget _formBtn(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          //验证通过提交数据
          _formKey.currentState.save();

          if (widget.params['id'] == null) {
            if (await context.read<OrderProvider>().handleCreate()) {
              Timer(Duration(seconds: 1), () {
                Navigator.of(context).pop();
              });
            }
          } else {
            if (await context.read<OrderProvider>().handleUpdate()) {
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
          widget.params["id"] == null ? '确认发布' : '确认修改',
          style: TextStyle(color: Colors.white, fontSize: 28.sp),
        ),
      ),
    );
  }
}
