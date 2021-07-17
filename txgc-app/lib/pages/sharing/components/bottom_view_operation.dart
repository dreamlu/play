import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/btn.dart';
import 'package:txgc_app/components/modal.dart';
import 'package:txgc_app/provides/folder.dart';
import 'package:txgc_app/utils/confirm_dialog.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/index.dart';

class BottomViewOperation extends StatelessWidget {
  final List<MediaModalType> mediaTypeData = [
    new MediaModalType('新建文件夹', 'images/folder.png', isShowBorder: true),
    new MediaModalType(
      '上传资源',
      'images/media.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    bool isRemove = context.watch<FolderProvider>().isRemove;

    /// 新建文件夹/上传资源
    void handleMedia() async {
      if (isRemove) {
        context.read<FolderProvider>().handleRemove(false);
      } else {
        String type = await openModalBottomSheet(context,
            title: '请选择新建文件夹还是上传资源',
            isShowHeader: true,
            mediaTypeData: mediaTypeData);

        if (type == mediaTypeData[0].label) {
          await globalModal(
            context,
            formKey: 'remark',
            title: '新建文件夹',
            titleColor: Color(0xFF000000),
            keyboardType: TextInputType.text,
            hintText: '点击输入文件夹名称',
            cancelTitle: '取消创建',
            cancelBgColor: Color(0xFFD2D2D2),
            okTitle: '确认创建',
            okBgColor: Color(0xFF009CFF),
          );
        } else {
          await showMediaModal(context,
              title: '请选择新建文件夹还是上传资源', isShowHeader: true);
        }
      }
    }

    void handleRemove() {
      if (isRemove) {
        if (context.read<FolderProvider>().selectIdx >= 2) {
          confirmDialog(context,
              title: '删除所选文件',
              desc: '是否确认删除所选文件？',
              cancelText: '取消删除',
              okText: '确认删除');
        } else {
          confirmDialog(context,
              title: '删除文件夹',
              desc: '是否确认删除文件夹？删除文件夹后文件夹下所有文件都将被删除',
              cancelText: '取消删除',
              okText: '确认删除');
        }
      } else {
        context.read<FolderProvider>().handleRemove(true);
      }
    }

    return Container(
      width: 750.w,
      height: (130 + Global.areaHeight).h,
      padding:
          EdgeInsets.only(bottom: Global.areaHeight.h, left: 25.w, right: 25.w),
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
            isRemove ? '取消删除' : '新建文件夹/上传资源',
            Color(0xFF009CFF),
            width: 450,
            onTap: handleMedia,
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
    );
  }
}
