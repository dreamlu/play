import 'dart:async';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/form_checkbox.dart';
import 'package:txgc_app/components/hr.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/main.dart';
import 'package:txgc_app/provides/meeting.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/index.dart';
import 'components/mana_form_item.dart';

class MeetingSchedulePage extends StatefulWidget {
  final Map<String, dynamic> params;
  MeetingSchedulePage(this.params);
  @override
  _MeetingSchedulePageState createState() => _MeetingSchedulePageState();
}

class _MeetingSchedulePageState extends State<MeetingSchedulePage>
    with RouteAware {
  GlobalKey<FormState> _formKey;
  List<CheckBoxType> meetingTypeList = [
    new CheckBoxType('线上会议', false, 'typ'),
    new CheckBoxType('线下会议', false, 'typ_o'),
  ];
  List<CheckBoxType> checkTypeList = [
    new CheckBoxType('是', false, 'is_remind'),
    new CheckBoxType('否', false, 'remind_n'),
  ];

  @override
  void initState() {
    _formKey = new GlobalKey<FormState>();
    super.initState();
    print(widget.params["id"] == null);
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
      '发起会议日程',
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
              ManaFormItem(
                'name',
                "会议名称",
                "请输入会议名称",
                isClear: true,
              ),
              ManaFormItem(
                'start_time',
                "会议开始日期",
                "选择年月日 ›",
                isCustPicker: true,
                value: Global.formRecord['start_time'],
                onPicker: () {
                  handleDatePickerModal(context);
                },
              ),
              Hr(
                margin: EdgeInsets.only(bottom: 40.h, top: 20.h),
              ),
              ManaFormItem('join_ids', "参会人员", "选择参会人员 ›", isCustPicker: true,
                  onPicker: () {
                Application.router.navigateTo(
                    context, '/meeting/project?isMultiple=1',
                    transition: TransitionType.native);
              },
                  value: Global.formRecord['join_ids'] is List
                      ? Global.formRecord['join_ids']
                          .map((e) => e.name)
                          .join(',')
                      : null),
              ManaFormItem('record_name', "会议记录人员", "选择会议记录人员 ›", onPicker: () {
                Application.router.navigateTo(
                    context, '/meeting/project?isMultiple',
                    transition: TransitionType.native);
              }, isCustPicker: true, value: Global.formRecord['record_name']),
              Hr(
                margin: EdgeInsets.only(bottom: 40.h, top: 20.h),
              ),
              FormCheckBox('会议形式', meetingTypeList, single: true),
              ManaFormItem(
                'plat',
                "会议平台",
                "请输入会议开展平台",
                isClear: true,
              ),
              Hr(
                margin: EdgeInsets.only(bottom: 40.h, top: 20.h),
              ),
              FormCheckBox('是否定时提示参会人员', checkTypeList, single: true),
              ManaFormItem(
                'remind',
                "会议提示",
                "请输入时间",
                prefix: Container(
                  padding: EdgeInsets.only(right: 24.w, top: 20.w),
                  child: Text(
                    '会议开始前',
                    style: TextStyle(color: Colors.black, fontSize: 28.sp),
                  ),
                ),
                suffix: Container(
                  padding: EdgeInsets.only(left: 30.w, top: 20.w),
                  child: Text(
                    '（分钟）进行提醒',
                    style: TextStyle(color: Colors.black, fontSize: 28.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
        widget.params["id"] == null ? _formBtn(context) : Container()
      ]),
    );
  }

  /// 选择时间
  void handleDatePickerModal(BuildContext context) {
    showDatePickerModal(context, onConfirm: (Picker picker, List value) {
      Global.formRecord['start_time'] =
          picker.adapter.toString().substring(0, 19);
      setState(() {});
    }, onSelect: (Picker picker, int index, List<int> selecteds) {});
  }

  void handleShowPickerModal(BuildContext context, List data) {
    Picker(
        adapter: PickerDataAdapter<String>(pickerdata: data),
        selectedTextStyle: TextStyle(color: Theme.of(context).primaryColor),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.adapter.text);
        }).showModal(this.context); //_scaffoldKey.currentState);
  }

  Widget _formBtn(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          //验证通过提交数据
          _formKey.currentState.save();
          if (await context.read<MeetingProvider>().handleCreate()) {
            Timer(Duration(seconds: 1), () {
              Navigator.of(context).pop();
            });
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
          '确认发布',
          style: TextStyle(color: Colors.white, fontSize: 28.sp),
        ),
      ),
    );
  }
}
