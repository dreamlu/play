import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:txgc_app/provides/car.dart';
import 'package:txgc_app/provides/car_driver.dart';
import 'package:txgc_app/provides/engine.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/mana_form_item.dart';

class DriverManaPage extends StatefulWidget {
  final Map<String, dynamic> params;

  DriverManaPage(this.params);

  @override
  _DriverManaPageState createState() => _DriverManaPageState();
}

class _DriverManaPageState extends State<DriverManaPage> {
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = new GlobalKey<FormState>();
    Timer(Duration(milliseconds: 400), () {
      getEngine(context, true);
      getCar(context, true);
    });
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
      widget.params["id"] == null ? '新增司机' : '司机编辑',
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
              ManaFormItem('name', "司机姓名", "请输入司机真实姓名", isClear: true),
              ManaFormItem('phone', "联系电话", "请输入司机的联系电话", isClear: true),
              ManaFormItem('account', "司机账号", "请输入司机登录账号", isClear: true),
              ManaFormItem('password', "司机密码", "请输入司机登录密码", isClear: true),
              // ManaFormItem('phone', "当前所在项目部", "选择司机当前所在项目部 ›",
              //     isCustPicker: true, onPicker: () {
              //   handleShowPickerModal(context, [
              //     '第一项目部',
              //     '第二项目部',
              //   ]);
              // }),
              ManaFormItem('engine_name', "当前所在工程", "选择司机当前所在工程 ›",
                  isCustPicker: true, onPicker: () {
                handleShowPickerModal(
                    context,
                    context
                        .read<EngineProvider>()
                        .listData
                        .map((e) => e.name)
                        .toList(),
                    'engine_id',
                    'engine_name');
              }, value: Global.formRecord['engine_name']),
              ManaFormItem('pr_car_plate', "当前驾驶车辆", "选择司机所开车辆牌照 ›",
                  isCustPicker: true, onPicker: () {
                handleShowPickerModal(
                    context,
                    context
                        .read<CarProvider>()
                        .listData
                        .map((e) => e.plate)
                        .toList(),
                    'pr_car_id',
                    'pr_car_plate');
              }, value: Global.formRecord['pr_car_plate']),
            ],
          ),
        ),
        _formBtn(context)
      ]),
    );
  }

  void handleShowPickerModal(
      BuildContext context, List data, String value, String label) {
    Picker(
        adapter: PickerDataAdapter<String>(pickerdata: data),
        selectedTextStyle: TextStyle(color: Theme.of(context).primaryColor),
        onConfirm: (Picker picker, List selected) {
          Global.formRecord[value] = value == 'engine_id'
              ? context.read<EngineProvider>().listData[selected[0]].id
              : selected[0];
          Global.formRecord[label] = data[selected[0]];
          setState(() {});
        }).showModal(this.context); //_scaffoldKey.currentState);
  }

  Widget _formBtn(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          //验证通过提交数据
          _formKey.currentState.save();
          if (widget.params['id'] == null) {
            if (await context.read<CarDriverProvider>().handleCreate()) {
              Timer(Duration(seconds: 1), () {
                Navigator.of(context).pop();
              });
            }
          } else {
            if (await context.read<CarDriverProvider>().handleUpdate()) {
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
          widget.params["id"] == null ? '确认新增' : '确认修改',
          style: TextStyle(color: Colors.white, fontSize: 28.sp),
        ),
      ),
    );
  }

  getEngine(BuildContext context, bool isReset) async {
    await context.read<EngineProvider>().getData(
          isReset: isReset,
        );
  }

  getCar(BuildContext context, bool isReset) async {
    await context.read<CarProvider>().getData(
          isReset: isReset,
        );
  }
}
