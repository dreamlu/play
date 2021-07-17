import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/provides/user.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:provider/provider.dart';
import 'components/user_form_item.dart';

class UserLoginPage extends StatefulWidget {
  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = new GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset(
                  'images/login-logo.png',
                  fit: BoxFit.cover,
                ),
                _formList(),
              ],
            ),
            Image.asset(
              'images/login-pic.png',
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }

  Widget _formList() {
    return Form(
      key: _formKey,
      child: Wrap(
        children: [
          _formTitle(),
          UserFormItem(
            'account',
            "用户账号",
            "请输入您的用户账号",
            formItemPadding: EdgeInsets.only(
              bottom: 59.h,
            ),
          ),
          UserFormItem(
            'password',
            "用户密码",
            "请输入您的用户密码",
            obscureText: true,
            keyboardType: TextInputType.text,
            formItemPadding: EdgeInsets.only(
              bottom: 24.h,
            ),
          ),
          _formTips(),
          _formBtn(context),
        ],
      ),
    );
  }

  Widget _formTips() {
    return Container(
      margin: EdgeInsets.only(left: 83.w, bottom: 60.h),
      child: Text(
        '忘记密码请联系平台管理员/项目部总调度修改密码',
        style: TextStyle(
            color: Color(0xFFB2B2B2),
            fontSize: 24.sp,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _formTitle() {
    return Container(
      margin: EdgeInsets.only(left: 83.w, top: 78.h, bottom: 57.h),
      child: Text(
        '登录',
        style: TextStyle(
            color: Colors.black, fontSize: 48.sp, fontWeight: FontWeight.bold),
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
            Application.router.navigateTo(
              context,
              '/app',
              transition: TransitionType.native,
              clearStack: true,
            );
          }
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 83.w, right: 60.w, bottom: 59.h),
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
          '立即登录',
          style: TextStyle(color: Colors.white, fontSize: 32.sp),
        ),
      ),
    );
  }
}
