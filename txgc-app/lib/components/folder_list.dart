import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:txgc_app/components/refresh_footer.dart';
import 'package:txgc_app/components/refresh_header.dart';
import 'package:txgc_app/model/resource.dart';
import 'package:txgc_app/utils/global.dart';
import 'folder_item.dart';

/// 文件列表
/// [isEmpty] 是否暂无数据
/// [data] 数据列表
/// [noDataDesc] 暂无数据描述
/// [navPath] 页面导航路径
/// [folderTop] 距离顶部位移
/// [noDataImg] 暂无数据图片渲染
/// [getData] 获取数据加载函数
class FolderList<T extends Resource> extends StatelessWidget {
  final bool isEmpty;
  final List<T> data;
  final String noDataDesc;
  final String navPath;
  final double folderTop;
  final String noDataImg;
  final Future Function(BuildContext context, bool isReset) getData;
  FolderList(
    this.data,
    this.noDataDesc,
    this.noDataImg, {
    @required this.navPath,
    this.isEmpty = false,
    this.getData,
    this.folderTop = 400,
  }) : assert(navPath != null);

  @override
  Widget build(BuildContext context) {
    print(data);
    List<Widget> children = data
        .map<Widget>(
            (item) => FolderItem(item, data.indexOf(item), navPath: navPath))
        .toList();
    children.add(Container(
      height: (150 + Global.areaHeight).h,
    ));

    return EasyRefresh(
        header: RefreshHeader(),
        footer: RefreshFooter(),
        emptyWidget: data.length == 0 ? _taskEmpty() : null,
        firstRefresh: true,
        child: Container(
          child: Column(children: children),
        ),
        onRefresh: () async {
          getData(context, true);
        });
  }

  Widget _taskEmpty() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            noDataImg,
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.only(top: 55.h),
            child: Text(
              noDataDesc,
              style: TextStyle(color: Color(0xFFADBBCA), fontSize: 28.sp),
            ),
          )
        ],
      ),
    );
  }
}
