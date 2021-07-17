import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/question_form_item.dart';

class QuestionReceiptPage extends StatefulWidget {
  final Map<String, dynamic> params;
  QuestionReceiptPage(this.params);
  @override
  _QuestionReceiptPageState createState() => _QuestionReceiptPageState();
}

class _QuestionReceiptPageState extends State<QuestionReceiptPage> {
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
      widget.params["status"] == '0' ? '填写回执' : '查看回执',
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
              QuestionFormItem('name', "回执内容",
                  "填写问题回执内容详情，可填写内容：\n1.问题完成人员；\n2.问题完成时间；\n3.问题完成情况。",
                  minLines: 5,
                  enabled: widget.params["status"] == '0',
                  isClear: true),
              QuestionFormItem(
                'start_pic',
                "回执图片",
                "请上传回执图片",
                enabled: widget.params["status"] == '0',
                isMedia: true,
              ),
            ],
          ),
        ),
        widget.params["status"] == '0' ? _formBtn(context) : Container()
      ]),
    );
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
          '提交回执',
          style: TextStyle(color: Colors.white, fontSize: 28.sp),
        ),
      ),
    );
  }
}
