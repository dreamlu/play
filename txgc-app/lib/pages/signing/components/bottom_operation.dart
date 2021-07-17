import 'dart:async';

import 'package:day/day.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/modal.dart';
import 'package:txgc_app/components/btn.dart';
import 'package:txgc_app/provides/pdf.dart';
import 'package:txgc_app/provides/signature.dart';
import 'package:txgc_app/utils/global.dart';

class BottomOperation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isCert = context.watch<PdfProvider>().isCert;

    void handleSign() async {
      context.read<PdfProvider>().handleisCert(false);
      if (await context.read<PdfProvider>().handleSign()) {
        Global.formRecord['status'] = 1;
        await context.read<SignatureProvider>().handleStatus();
        Global.formRecord['timestamp'] = Day().millisecond();
        Timer(Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
      }
    }

    void handleAgree() async {
      Global.formRecord['password'] = '';
      bool isConfirm = await globalModal(context,
          formKey: 'password',
          keyboardType: TextInputType.text,
          hintText: '点击输入密码',
          cancelTitle: '取消使用',
          title: '同意签认',
          desc: '输入电子签名密码使用电子签名',
          titleColor: Color(0xFF00C86C),
          cancelBgColor: Color(0xFFD2D2D2),
          okTitle: '确认使用',
          okBgColor: Color(0xFF00C86C));
      if (isConfirm) {
        if (Global.userCache.password == Global.formRecord['password']) {
          context.read<PdfProvider>().handleisCert(true);
        } else {
          showToast('密码错误');
        }
      }
    }

    void handleReject() async {
      bool isConfirm = await globalModal(context,
          formKey: 'reason',
          title: '拒绝签认',
          desc: '若要拒绝签认请填写拒绝签认理由',
          titleColor: Color(0xFFFF6565),
          keyboardType: TextInputType.text,
          hintText: '点击输入拒绝理由',
          cancelTitle: '取消填写',
          cancelBgColor: Color(0xFFD2D2D2),
          okTitle: '确认提交',
          okBgColor: Color(0xFFFF6565),
          maxLines: 5);

      if (isConfirm) {
        /// 0未签认,1签认,2拒绝
        Global.formRecord['status'] = 2;
        context.read<SignatureProvider>().handleStatus();
      }
    }

    return Container(
      child: Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            width: 750.w,
            height: (130 + Global.areaHeight).h,
            padding: EdgeInsets.only(
                bottom: Global.areaHeight.h, left: 25.w, right: 25.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: isCert
                  ? [
                      BottomBtn('取消签认', Color(0xFF999999), onTap: () {
                        context.read<PdfProvider>().handleisCert(false);
                      }),
                      BottomBtn('确认提交', Color(0xFF009CFF), onTap: handleSign),
                    ]
                  : [
                      BottomBtn('拒绝签认', Color(0xFFFF6565), onTap: handleReject),
                      BottomBtn('同意签认', Color(0xFF00C86C),
                          desc: '在本页使用电子签名', onTap: handleAgree),
                    ],
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 15.w,
                    offset: Offset(-0, -3.0),
                    color: Color(0x45999999))
              ],
              color: Colors.white,
            ),
          )),
    );
  }
}
