import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:txgc_app/provides/car.dart';
import 'package:txgc_app/provides/engine.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/mana_form_item.dart';

class CarManaPage extends StatefulWidget {
  final Map<String, dynamic> params;

  CarManaPage(this.params);

  @override
  _CarManaPageState createState() => _CarManaPageState();
}

class _CarManaPageState extends State<CarManaPage> {
  GlobalKey<FormState> _formKey;
  final List<String> carList = [
    '小型汽车',
    '中型汽车',
  ];

  final List<String> carStatus = [
    '正常',
    '报修',
  ];

  @override
  void initState() {
    super.initState();
    _formKey = new GlobalKey<FormState>();
    Timer(Duration(milliseconds: 400), () {
      getEngine(context, true);
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
      widget.params["id"] == null ? '新增车辆' : '车辆编辑',
    );
  }

  Widget _formList() {
    int typ = Global.formRecord['typ'];
    int status = Global.formRecord['status'];
    Global.formRecord['typ_v'] = typ == null
        ? ''
        : typ == 0
            ? carList[0]
            : carList[1];
    Global.formRecord['status_v'] = status == null
        ? ''
        : status == 0
            ? carStatus[0]
            : carStatus[1];
    return Form(
      key: _formKey,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          constraints: BoxConstraints(
              minHeight: (Global.fullHeight - Global.areaHeight - 322).h),
          child: Wrap(
            children: [
              ManaFormItem('plate', "车辆牌照", "请输入新增车辆牌照", isClear: true),
              ManaFormItem('typ_v', "车辆类型", "选择新增车辆类型 ›", isCustPicker: true,
                  onPicker: () {
                handleShowPickerModal(context, carList, 'typ', 'typ_v');
              }, value: Global.formRecord['typ_v']),
              // ManaFormItem('project_name', "当前所在项目部", "选择车辆所在项目部 ›",
              //     isCustPicker: true, onPicker: () {
              //   handleShowPickerModal(context, [
              //     '第一项目部',
              //     '第二项目部',
              //   ]);
              // }),
              ManaFormItem('engine_name', "当前所在工程", "选择车辆所在工程 ›",
                  isCustPicker: true, onPicker: () async {
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
              ManaFormItem(
                'status_v',
                "车辆当前状态",
                "选择车辆当前状态 ›",
                isCustPicker: true,
                onPicker: () {
                  handleShowPickerModal(
                      context, carStatus, 'status', 'status_v');
                },
                value: Global.formRecord['status_v'],
              ),
            ],
          ),
        ),
        _formBtn(context)
      ]),
    );
  }

  void handleShowPickerModal(
    BuildContext context,
    List data,
    String value,
    String label,
  ) {
    Picker(
      adapter: PickerDataAdapter<String>(pickerdata: data),
      selectedTextStyle: TextStyle(color: Theme.of(context).primaryColor),
      onConfirm: (Picker picker, List selected) {
        Global.formRecord[value] = value == 'engine_id'
            ? context.read<EngineProvider>().listData[selected[0]].id
            : selected[0];
        Global.formRecord[label] = data[selected[0]];
        setState(() {});
      },
    ).showModal(this.context); //_scaffoldKey.currentState);
  }

  Widget _formBtn(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          //验证通过提交数据
          _formKey.currentState.save();
          if (widget.params['id'] == null) {
            if (await context.read<CarProvider>().handleCreate()) {
              Timer(Duration(seconds: 1), () {
                Navigator.of(context).pop();
              });
            }
          } else {
            if (await context.read<CarProvider>().handleUpdate()) {
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
    return '';
  }
}
