import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/btn.dart';
import 'package:txgc_app/components/modal.dart';
import 'package:txgc_app/model/task.dart';
import 'package:txgc_app/provides/task.dart';
import 'package:txgc_app/utils/global.dart';

class BottomOperation extends StatelessWidget {
  final Task task;
  BottomOperation(this.task);

  @override
  Widget build(BuildContext context) {
    void handleAgree() async {
      Global.formRecord['id'] = task.id;
      Global.formRecord['status'] = 1;
      if (await context.read<TaskProvider>().handleStatus()) {
        Timer(Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
      }
    }

    void handleReject() async {
      Global.formRecord['id'] = task.id;
      Global.formRecord['status'] = 2;
      await globalModal(context,
          formKey: 'reason',
          title: '拒绝接收',
          titleColor: Color(0xFFFF6565),
          keyboardType: TextInputType.text,
          hintText: '点击输入拒绝理由',
          cancelTitle: '取消填写',
          cancelBgColor: Color(0xFFD2D2D2),
          okTitle: '确认提交',
          okBgColor: Color(0xFFFF6565),
          maxLines: 5);
      if (await context.read<TaskProvider>().handleStatus()) {
        Timer(Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
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
              children: [
                BottomBtn(
                  '拒绝接收',
                  Color(0xFFFF6565),
                  onTap: handleReject,
                ),
                BottomBtn(
                  '确认接收',
                  Color(0xFF00C86C),
                  onTap: handleAgree,
                ),
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
