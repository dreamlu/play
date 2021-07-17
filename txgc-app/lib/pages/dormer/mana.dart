import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/mana_form_item.dart';

class DormerManaPage extends StatefulWidget {
  final Map<String, dynamic> params;
  DormerManaPage(this.params);
  @override
  _DormerManaPageState createState() => _DormerManaPageState();
}

class _DormerManaPageState extends State<DormerManaPage> {
  GlobalKey<FormState> _formKey;

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
      widget.params['id'] == null ? '发起天窗' : '编辑天窗',
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
              ManaFormItem('name', "天窗名称", "请输入天窗施工名称", isClear: true),
              ManaFormItem('phone', "所属工程", "选择天窗所属工程 ›", isCustPicker: true,
                  onPicker: () {
                handleShowPickerModal(context, ['第一工程部', '第二工程部', '第三工程部']);
              }),
              ManaFormItem('phone', "所属施工项目部", "选择天窗所属施工项目部 ›",
                  isCustPicker: true, onPicker: () {
                handleShowPickerModal(
                    context, ['第一工程项目部', '第二工程项目部', '第三工程项目部']);
              }),
              ManaFormItem('phone', "天窗负责人", "从施工项目部选择人员 ›", isCustPicker: true,
                  onPicker: () {
                handleShowPickerModal(context, ['张三', '李四', '王五']);
              }),
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
          widget.params['id'] == null ? '确认发布' : '确认修改',
          style: TextStyle(color: Colors.white, fontSize: 28.sp),
        ),
      ),
    );
  }
}
