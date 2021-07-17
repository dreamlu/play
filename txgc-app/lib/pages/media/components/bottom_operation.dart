import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/btn.dart';
import 'package:txgc_app/components/modal.dart';
import 'package:txgc_app/provides/folder.dart';
import 'package:txgc_app/provides/resource.dart';
import 'package:txgc_app/utils/confirm_dialog.dart';
import 'package:txgc_app/utils/global.dart';

class BottomOperation extends StatelessWidget {
  void handleCreate(BuildContext context, bool isRemove) async {
    if (isRemove) {
      context.read<FolderProvider>().handleRemove(false);
    } else {
      bool isConfirm = await globalModal(
        context,
        formKey: 'name',
        title: '新建文件夹',
        titleColor: Color(0xFF000000),
        keyboardType: TextInputType.text,
        hintText: '点击输入文件夹名称',
        cancelTitle: '取消创建',
        cancelBgColor: Color(0xFFD2D2D2),
        okTitle: '确认创建',
        okBgColor: Color(0xFF009CFF),
      );
      if (isConfirm) {
        Global.formRecord['typ'] = 4;
        await context.read<ResourceProvider>().handleCreate();
        await context.read<ResourceProvider>().getData(isReset: true, pid: 0);
      }
    }
  }

  void handleRemove(BuildContext context, bool isRemove) async {
    if (isRemove) {
      bool isConfirm = await confirmDialog(context,
          title: '删除文件夹',
          desc: '是否确认删除文件夹？删除文件夹后文件夹下所有文件都将被删除',
          cancelText: '取消删除',
          okText: '确认删除');
      if (isConfirm) {
        if (await context.read<ResourceProvider>().handleRemove()) {
          context.read<FolderProvider>().handleRemove(false);
          context.read<FolderProvider>().handleSelect(-1);
        }
      }
    } else {
      context.read<FolderProvider>().handleRemove(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isRemove = context.watch<FolderProvider>().isRemove;
    return Container(
      child: Container(
        width: 750.w,
        height: (130 + Global.areaHeight).h,
        padding: EdgeInsets.only(
            bottom: Global.areaHeight.h, left: 25.w, right: 25.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomBtn(
              isRemove ? '完成选择' : '删除文件夹',
              Color(0xFFFF6565),
              onTap: () {
                handleRemove(context, isRemove);
              },
            ),
            BottomBtn(
              isRemove ? '取消删除' : '新建文件夹',
              Color(0xFF009CFF),
              onTap: () {
                handleCreate(context, isRemove);
              },
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
      ),
    );
  }
}
