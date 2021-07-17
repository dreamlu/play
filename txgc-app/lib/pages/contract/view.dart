import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:txgc_app/components/breadcrumbs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/folder_list.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:txgc_app/components/top_pic.dart';
import 'package:txgc_app/model/resource.dart';
import 'package:txgc_app/provides/contract.dart';
import 'package:txgc_app/provides/folder.dart';
import 'package:txgc_app/routers/router_role.dart';
import 'components/bottom_view_operation.dart';

class ContractViewPage extends StatelessWidget {
  final Map<String, dynamic> params;

  ContractViewPage(this.params);

  // 项目部的所有人都可以看和下载，不能上传

  // 平台管理员 项目总调度 影像资料管理员可删除文件夹
  final bool isCanFolderMana = RouterRole.isCanMana(['-1', '0', '8']);

  // 平台管理员 选择项目部
  final bool isCanProjectMana = RouterRole.isCanMana(['-1']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => FolderProvider()),
            ChangeNotifierProvider(create: (_) => ContractProvider()),
          ],
          builder: (BuildContext context, child) => Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _topBanner(),
                    Breadcrumbs(params['pName']),
                    _listScroll(context)
                  ],
                ),
              ),
              isCanFolderMana ? BottomViewOperation() : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBanner() {
    return Container(
      height: 300.h,
      child: Stack(
        children: [
          TopPic(
            'images/contract-pic.png',
          ),
          NavBack(),
        ],
      ),
    );
  }

  Widget _listScroll(BuildContext context) {

    return Expanded(
      child: FolderList(context.watch<ContractProvider>().listData, '暂无文件列表', 'images/file-empty.png',
          getData: getData, navPath: 'contract'),
    );
  }

  Future getData(BuildContext context, bool isReset) async {
    await context
        .read<ContractProvider>()
        .getData(isReset: isReset, pid: int.parse(params['pid']));
    return '';
  }
}
