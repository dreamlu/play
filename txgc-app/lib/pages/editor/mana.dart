import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/form_checkbox.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/main.dart';
import 'package:txgc_app/provides/share_edit.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/mana_form_item.dart';

class EditorManaPage extends StatefulWidget {
  final Map<String, dynamic> params;
  EditorManaPage(this.params);
  @override
  _EditorManaPageState createState() => _EditorManaPageState();
}

class _EditorManaPageState extends State<EditorManaPage> with RouteAware {
  GlobalKey<FormState> _formKey;
  List<CheckBoxType> checkListPub = [
    new CheckBoxType('是', false, 'is_public'),
    new CheckBoxType('否', false, 'is_public_of'),
  ];
  List<CheckBoxType> checkListAny = [
    new CheckBoxType('是', false, 'is_ay'),
    new CheckBoxType('否', false, 'is_ay_of'),
  ];

  @override
  void initState() {
    _formKey = new GlobalKey<FormState>();
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
      // context.read<TaskProvider>().getData(isReset: true, status: this.tabIdx);
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
      '发起共享编辑',
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
              ManaFormItem('name', "标题", "请输入共享编辑标题", isClear: true),
              ManaFormItem(
                'phone',
                "接收人/部门",
                "选择共享编辑指派给的接收人/部门 ›",
                isCustPicker: true,
                onPicker: () {
                  Application.router.navigateTo(
                      context, '/handover/project?isMultiple=1',
                      transition: TransitionType.native);
                },
                value: Global.formRecord['receive_ids']
                    ?.map((item) => item.name)
                    ?.join(','),
              ),
              ManaFormItem('content', "描述", "请输入共享编辑的相关描述", isClear: true),
              FormCheckBox(
                '是否公开',
                checkListPub,
                single: true,
                tooltips: '提交上来的信息是否所有人都能看到全部信息',
              ),
              FormCheckBox(
                '是否匿名',
                checkListAny,
                single: true,
                tooltips: '提交上来的信息是否所有人都能看到全部信息',
              ),
            ],
          ),
        ),
        _formBtn(context)
      ]),
    );
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

          if (await context.read<ShareEditProvider>().handleCreate()) {
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
          '确认发起',
          style: TextStyle(color: Colors.white, fontSize: 28.sp),
        ),
      ),
    );
  }
}
