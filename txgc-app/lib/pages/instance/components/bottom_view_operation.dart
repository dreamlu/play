import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/btn.dart';
import 'package:txgc_app/provides/cs_example.dart';
import 'package:txgc_app/provides/folder.dart';
import 'package:txgc_app/routers/router_role.dart';
import 'package:txgc_app/utils/confirm_dialog.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/index.dart';

class BottomViewOperation extends StatelessWidget {

  final int pid;
  final Future Function(BuildContext context, bool isReset) getData;

  BottomViewOperation({this.pid, this.getData});

  // 平台管理员 项目总调度 影像资料管理员可删除文件夹
  final bool isCanFolderMana = RouterRole.isCanMana(['-1', '0', '7']);
  // 平台管理员 选择项目部
  final bool isCanProjectMana = RouterRole.isCanMana(['-1']);

  final List<MediaModalType> mediaTypeData = [
    new MediaModalType('新建文件夹', 'images/folder.png', isShowBorder: true),
    new MediaModalType(
      '上传影像资料',
      'images/media.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    bool isRemove = context.watch<FolderProvider>().isRemove;

    void handleRemove() async {
      if (isRemove) {
        if (context.read<FolderProvider>().selectIdx >= 2) {
          bool isConfirm = await confirmDialog(context,
              title: '删除所选文件',
              desc: '是否确认删除所选文件？',
              cancelText: '取消删除',
              okText: '确认删除');
          if (isConfirm) {
            if (await context.read<CsExampleProvider>().handleRemove()) {
              context.read<FolderProvider>().handleRemove(false);
              context.read<FolderProvider>().handleSelect(-1);
            }
          }
        } else {
          bool isConfirm = await confirmDialog(context,
              title: '删除文件夹',
              desc: '是否确认删除文件夹？删除文件夹后文件夹下所有文件都将被删除',
              cancelText: '取消删除',
              okText: '确认删除');
          if (isConfirm) {
            if (await context.read<CsExampleProvider>().handleRemove()) {
              context.read<FolderProvider>().handleRemove(false);
              context.read<FolderProvider>().handleSelect(-1);
            }
          }
        }
      } else {
        context.read<FolderProvider>().handleRemove(true);
      }
    }

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
              isRemove ? '完成选择' : '删除',
              Color(0xFFFF6565),
              width: 230,
              onTap: handleRemove,
            ),
            BottomBtn(
              isRemove ? '取消删除' : '上传案例库文件',
              Color(0xFF009CFF),
              width: 450,
              onTap: () async {
                if (isRemove) {
                  context.read<FolderProvider>().handleRemove(false);
                } else {
                  await showMediaModal(context,
                      title: '请选择案例库文件上传方式',
                      desc: '案例文件资源请通过PC端进行上传',
                      isShowHeader: true);
                }
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
