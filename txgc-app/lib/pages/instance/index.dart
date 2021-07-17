import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/folder_list.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:txgc_app/components/project_picker.dart';
import 'package:txgc_app/components/top_pic.dart';
import 'package:txgc_app/model/resource.dart';
import 'package:txgc_app/provides/cs_example.dart';
import 'package:txgc_app/provides/folder.dart';
import 'package:txgc_app/routers/router_role.dart';
import 'components/bottom_operation.dart';

class InstancePage extends StatelessWidget {
  // 平台管理员 项目总调度 施工安全典型案例管理员可删除文件夹
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
            ChangeNotifierProvider(create: (_) => CsExampleProvider()),
          ],
          builder: (BuildContext context, child) => Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _topBanner(),
                    _projectList(context),
                    _listScroll(context)
                  ],
                ),
              ),
              isCanFolderMana ? BottomOperation() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _projectList(BuildContext context) {
    return isCanProjectMana
        ? ProjectPicker([
            '信号第一项目部',
            '信号第二项目部',
          ], '请选择项目部', onChange: (String val) {
            print(val);
          })
        : Container();
  }

  Widget _listScroll(BuildContext context) {
    final List<Resource> listData = context.watch<CsExampleProvider>().listData;

    return Expanded(
      child: FolderList(listData, '暂无文件夹列表', 'images/file-empty.png',
          getData: getData, navPath: 'instance'),
    );
  }

  Widget _topBanner() {
    return Container(
      height: 300.h,
      child: Stack(
        children: [
          TopPic(
            'images/instance-pic.png',
          ),
          NavBack(),
        ],
      ),
    );
  }

  Future getData(BuildContext context, bool isReset) async {
    await context.read<CsExampleProvider>().getData(isReset: isReset, pid: 0);
    return '';
  }
}