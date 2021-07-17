import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/provides/user.dart';
import 'package:provider/provider.dart';
import 'components/user_form_item.dart';

class UserPasswordPage extends StatefulWidget {
  @override
  _UserPasswordPageState createState() => _UserPasswordPageState();
}

class _UserPasswordPageState extends State<UserPasswordPage> {
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = new GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TopAppBar(
      SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 90.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _formList(),
              Image.asset(
                'images/login-pic.png',
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      ),
      '修改密码',
      resizeToAvoidBottomPadding: true,
    );
  }

  Widget _formList() {
    return Form(
      key: _formKey,
      child: Wrap(
        children: [
          UserFormItem(
            'phone',
            "原密码",
            "请输入原密码",
            obscureText: true,
            formItemPadding: EdgeInsets.only(
              bottom: 59.h,
            ),
            keyboardType: TextInputType.number,
          ),
          UserFormItem(
            'phone',
            "新密码",
            "请输入新密码",
            obscureText: true,
            formItemPadding: EdgeInsets.only(
              bottom: 59.h,
            ),
          ),
          UserFormItem(
            'code',
            "重新输入新密码",
            "请输入新密码",
            obscureText: true,
            formItemPadding: EdgeInsets.only(
              bottom: 24.h,
            ),
          ),
          _formBtn(context),
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
          if (await context.read<UserProvider>().handleLogin()) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Container(
        margin:
            EdgeInsets.only(left: 83.w, top: 50.h, right: 60.w, bottom: 59.h),
        width: 750.w,
        height: 90.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xFF009CFF),
            boxShadow: [
              BoxShadow(
                color: Color(0x2B007FCF),
                offset: Offset(0.0, 3.0),
                blurRadius: 9.0,
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
