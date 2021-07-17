import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/form_checkbox.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/provides/car_record.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/location.dart';
import 'components/mana_form_item.dart';
import 'package:provider/provider.dart';

class FuelManaPage extends StatefulWidget {
  final Map<String, dynamic> params;

  FuelManaPage(this.params);

  @override
  _FuelManaPageState createState() => _FuelManaPageState();
}

class _FuelManaPageState extends State<FuelManaPage> {
  GlobalKey<FormState> _formKey;
  List<CheckBoxType> checkList = [
    new CheckBoxType('车辆维修', false, 'typ_fix'),
    new CheckBoxType('车辆加油', false, 'typ_add'),
  ];
  String locDesc;

  @override
  void initState() {
    _formKey = new GlobalKey<FormState>();
    handleLocation();
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
      '新增上报',
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
                'plate',
                "车辆牌照",
                "请输入车辆牌照",
                // enabled: false,
              ),
              ManaFormItem(
                'car_type',
                "车辆类型",
                "请输入车辆类型",
                isCustPicker: true,
                onPicker: () {
                  handleShowPickerModal(context, ['小型车辆', '中型车辆']);
                },
              ),
              FormCheckBox('上报类型', checkList, single: true),
              ManaFormItem('address', "上报地点", "点击获取当前定位 ›",
                  isCustPicker: true, onPicker: handleLocation, value: locDesc),
              ManaFormItem('money', "上报金额", "请输入上报金额", isClear: true),
              ManaFormItem(
                'img_url',
                "上传图片",
                "请上传图片",
                isMedia: true,
              ),
            ],
          ),
        ),
        _formBtn(context)
      ]),
    );
  }

  /// 获取地理位置
  void handleLocation() async {
    final Location location = await getLocation();
    Global.formRecord['start_place'] = location.desc;
    setState(() {
      locDesc = location.desc;
    });
  }

  void handleShowPickerModal(BuildContext context, List data) {
    Picker(
        adapter: PickerDataAdapter<String>(pickerdata: data),
        selectedTextStyle: TextStyle(color: Theme.of(context).primaryColor),
        onConfirm: (Picker picker, List value) {
          // print(value.toString());
          // print(picker.adapter.text);
          Global.formRecord['car_type'] = data[value[0]];
        }).showModal(this.context); //_scaffoldKey.currentState);
  }

  Widget _formBtn(BuildContext context) {
    return InkWell(
      onTap: () async {
        // if (_formKey.currentState.validate()) {
        //验证通过提交数据
        _formKey.currentState.save();
        if (await context.read<CarRecordProvider>().handleCreate()) {
          Timer(Duration(seconds: 1), () {
            Navigator.of(context).pop();
          });
        }
        // }
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
}
