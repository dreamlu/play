import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/provides/order.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/order_form_item.dart';

class OrderReceiptPage extends StatefulWidget {
  final Map<String, dynamic> params;
  OrderReceiptPage(this.params);
  @override
  _OrderReceiptPageState createState() => _OrderReceiptPageState();
}

class _OrderReceiptPageState extends State<OrderReceiptPage> {
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
      int.parse(widget.params["status"]) % 2 == 0 ? '填写回执' : '查看回执',
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
              OrderFormItem('reply_content', "回执内容",
                  "填写工单回执内容详情，可填写内容：\n1.工单完成人员；\n2.工单完成时间；\n3.工单完成情况。",
                  minLines: 5,
                  enabled: int.parse(widget.params["status"]) % 2 == 0,
                  isClear: true),
              OrderFormItem(
                'reply_img',
                "回执图片",
                "请上传回执图片",
                enabled: int.parse(widget.params["status"]) % 2 == 0,
                isMedia: true,
              ),
            ],
          ),
        ),
        int.parse(widget.params["status"]) % 2 == 0
            ? _formBtn(context)
            : Container()
      ]),
    );
  }

  Widget _formBtn(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          //验证通过提交数据
          _formKey.currentState.save();
          if (await context.read<OrderProvider>().handleReply()) {
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
          '提交回执',
          style: TextStyle(color: Colors.white, fontSize: 28.sp),
        ),
      ),
    );
  }
}
