import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/form_radius.dart';
import 'package:txgc_app/constants/index.dart';
import 'package:txgc_app/model/resource.dart';
import 'package:txgc_app/provides/folder.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/index.dart';

/// 文件单个item
/// [name] 文件名
/// [url] 文件地址
/// [navPath] 页面导航路径
/// [index] 存在列表中的索引
/// [isCheck] 是否可选则删除
/// [isContract] 是否为合同
/// [isFolder] 是否为文件夹
class FolderItem extends StatelessWidget {
  final Resource item;
  final String navPath;
  final int index;

  FolderItem(this.item, this.index, {this.navPath = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40.w),
      // height: 107.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _folderName(context),
          item.isFolder ? Image.asset('images/right-tri.png') : Container()
        ],
      ),
    );
  }

  String _fileSuffix(String url) {
    String type = lookupMimeType(url);

    String suffix = 'folder.png';
    if (type != null) {
      if (type.startsWith('image/')) {
        suffix = 'img.png';
      } else if (type == 'application/pdf') {
        suffix = 'pdf.png';
      } else if (type.startsWith('video/')) {
        suffix = 'video.png';
      } else if (type.startsWith('audio/')) {
        suffix = 'music.png';
      }
    }
    return suffix;
  }

  Widget _userInfo() {
    return Container(
      margin: EdgeInsets.only(left: 27.w),
      child: Wrap(
        children: [
          Text(
            '上传人：${item.projectPersonName} | ${item.content}',
            style: TextStyle(color: Color(0xFF999999), fontSize: 18.sp),
          )
        ],
      ),
    );
  }

  Widget _folderName(BuildContext context) {
    bool isRemove = context.watch<FolderProvider>().isRemove;
    if (!item.isCheck) {
      isRemove = false;
    }
    int selectIdx = context.watch<FolderProvider>().selectIdx;
    return InkWell(
      onTap: () {
        if (isRemove) {
          Global.formRecord['id'] = item.id;

          context.read<FolderProvider>().handleSelect(index);
        } else if (item.isFolder) {
          Application.router.navigateTo(context,
              '/$navPath/view?pid=${item.id}&pName=${Uri.encodeComponent(item.name)}',
              transition: TransitionType.native);
        } else if (item.isContract) {
          Global.formRecord = {};
          Global.formRecord = item.toJson();

          Application.router.navigateTo(context, '/$navPath/preview',
              transition: TransitionType.native);
        } else {
          mediaPreviewer(context, MEDIA_PREFIX + item.url, name: item.name);
        }
      },
      child: Container(
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 27.w),
              child: Image.asset('images/${_fileSuffix(item.url)}'),
            ),
            Container(
              width: 577.w,
              padding: EdgeInsets.symmetric(vertical: 30.h),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(width: 1.w, color: Color(0xFFE6E6E6)))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      isRemove
                          ? FormRadius(
                              isCheck: selectIdx == index ? true : false,
                            )
                          : Container(),
                      Container(
                        width: 500.w,
                        margin: EdgeInsets.only(left: 27.w),
                        child: Text(
                          item.name,
                          style: TextStyle(
                              color: Color(0xFF000000), fontSize: 28.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  item.isFolder || item.projectPersonName != ''
                      ? Container()
                      : _userInfo()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
