import 'dart:async';
import 'package:flutter/material.dart';
import 'package:txgc_app/components/form_checkbox.dart';
import 'package:txgc_app/components/hr.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/provides/user.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/setting_form_item.dart';

class UserSettingPage extends StatefulWidget {
  @override
  _UserSettingPageState createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  GlobalKey<FormState> _formKey;
  List<CheckBoxType> checkList = [
    new CheckBoxType('男', false, 'meal'),
    new CheckBoxType('女', false, 'female'),
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
          child: _formList(),
        ),
        '个人信息');
  }

  Widget _formList() {
    return Form(
      key: _formKey,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Wrap(
          children: [
            SettingFormItem('name', "个人姓名", "请输入您的个人姓名", isClear: true),
            FormCheckBox(
              '工单提醒方式',
              checkList,
              single: true,
            ),
            SettingFormItem('phone', "联系方式", "请输入您的联系方式",
                keyboardType: TextInputType.phone, isClear: true),
            Hr(),
            _verified()
          ],
        ),
        _formBtn(context)
      ]),
    );
  }

  Widget _verified() {
    return Container(
      margin: EdgeInsets.only(left: 27.w, top: 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '实名认证',
            style: TextStyle(
                color: Colors.black,
                fontSize: 32.sp,
                fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(top: 9.h),
            child: Text(
              '若要更改请联系平台管理员进行更改',
              style: TextStyle(color: Color(0xFF999999), fontSize: 24.sp),
            ),
          ),
          Container(
            width: 690.w,
            margin: EdgeInsets.only(top: 29.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'images/idcard-front.png',
                  width: 330.w,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'images/idcard-back.png',
                  width: 330.w,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _formBtn(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          //验证通过提交数据
          _formKey.currentState.save();
          if (await context.read<UserProvider>().handleUpdate()) {
            Timer(Duration(seconds: 2), () {
              Navigator.of(context).pop();
            });
          }
        }
      },
      child: Container(
        margin: EdgeInsets.only(
            bottom: (40 + Global.areaHeight).h, left: 25.w, right: 25.w),
        width: 750.w,
        height: 90.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xFF009CFF),
            boxShadow: [
              BoxShadow(
                color: Color(0x45005489),
                offset: Offset(0, 2.0),
                blurRadius: 5.0,
              )
            ],
            borderRadius: BorderRadius.circular(10.w)),
        child: Text(
          '确认修改',
          style: TextStyle(color: Colors.white, fontSize: 32.sp),
        ),
      ),
    );
  }
}
