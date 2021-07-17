import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/hr.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/index.dart';
import '../../components/form_checkbox.dart';
import 'components/question_form_item.dart';

class QuestionManaPage extends StatefulWidget {
  final Map<String, dynamic> params;
  QuestionManaPage(this.params);
  @override
  _QuestionManaPageState createState() => _QuestionManaPageState();
}

class _QuestionManaPageState extends State<QuestionManaPage> {
  GlobalKey<FormState> _formKey;
  List<CheckBoxType> checkList = [
    new CheckBoxType('APP消息提醒', false, 'app'),
    new CheckBoxType('手机短信提醒', false, 'msg'),
  ];

  @override
  void initState() {
    _formKey = new GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TopAppBar(
      Container(
        child: SingleChildScrollView(
          child: _formList(),
        ),
      ),
      widget.params["id"] == null ? '发起问题库克缺' : '编辑问题',
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
              QuestionFormItem('name', "问题名称", "请输入问题名称", isClear: true),
              QuestionFormItem('phone', "问题负责人", "从项目部选择人员 ›",
                  isCustPicker: true, onPicker: () {
                handleShowPickerModal(context, ['张三', '李四', '王五']);
              }),
              QuestionFormItem('deadline', "问题截止时间", "选择截止时间 ›",
                  isCustPicker: true, onPicker: () {
                handleDatePickerModal(context);
              }),
              Hr(margin: EdgeInsets.only(bottom: 40.h)),
              QuestionFormItem(
                'phone',
                "问题自动提醒",
                "请输入",
                prefix: Container(
                  padding: EdgeInsets.only(right: 24.w, top: 20.w),
                  child: Text(
                    '问题截止时间',
                    style: TextStyle(color: Colors.black, fontSize: 28.sp),
                  ),
                ),
                suffix: Container(
                  padding: EdgeInsets.only(left: 30.w, top: 20.w),
                  child: Text(
                    '(小时)提醒问题负责人',
                    style: TextStyle(color: Colors.black, fontSize: 28.sp),
                  ),
                ),
              ),
              FormCheckBox('问题提醒方式', checkList),
              Hr(margin: EdgeInsets.only(bottom: 40.h)),
              QuestionFormItem(
                'name',
                "问题内容",
                "填写问题回执内容详情，可填写内容：\n1.问题需要完成内容。",
                isClear: true,
                minLines: 5,
              ),
              QuestionFormItem(
                'name',
                "问题图片",
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
      print(picker.adapter.text);
    }, onSelect: (Picker picker, int index, List<int> selecteds) {
      Global.formRecord['deadline'] = picker.adapter.toString();
    });
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
          // if (await context.read<UserProvider>().handleUpdate()) {
          //   Timer(Duration(seconds: 2), () {
          //     Navigator.of(context).pop();
          //   });
          // }
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
