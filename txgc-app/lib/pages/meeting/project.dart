import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/dark_tab.dart';
import 'package:txgc_app/components/refresh_footer.dart';
import 'package:txgc_app/components/refresh_header.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/components/top_search.dart';
import 'package:provider/provider.dart';
import 'package:txgc_app/components/tree_view.dart';
import 'package:txgc_app/model/person.dart';
import 'package:txgc_app/provides/person.dart';
import 'components/bottom_project_confirm.dart';
import 'components/project_item.dart';

class MeetingProjectPage extends StatefulWidget {
  final Map<String, dynamic> params;
  MeetingProjectPage(this.params);
  @override
  _MeetingProjectPageState createState() => _MeetingProjectPageState();
}

class _MeetingProjectPageState extends State<MeetingProjectPage> {
  List tabList = [
    {'label': '人员选择', 'value': 0},
    {'label': '部门选择', 'value': 1},
  ];

  int tabIdx = 0;

  void onTap(int tabIdx) {
    setState(() {
      this.tabIdx = tabIdx;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TopAppBar(
        Container(
            margin: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 20.h),
            child: Theme(
              data: Theme.of(context).copyWith(
                primaryColor: Color(0xFF009CFF),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Column(children: [
                      DarkTab(
                        this.tabList,
                        onTap,
                        padding: EdgeInsets.all(0),
                      ),
                      this.tabIdx == 0
                          ? TopSearch(
                              hintText: '根据关键字搜索人员',
                              padding: EdgeInsets.only(bottom: 20.h),
                              onEditingComplete: (String keywords) {
                                handleEditingComplete(context, keywords);
                              },
                            )
                          : Container(),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: tabIdx == 0
                                  ? _projectList(context)
                                  : _depList(),
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                  BottomProjectConfirm(
                      tabIdx: this.tabIdx,
                      isMultiple: widget.params['isMultiple'] ?? '0')
                ],
              ),
            )),
        '选择部门与人员');
  }

  Widget _projectList(BuildContext context) {
    final List<Person> listData = context.watch<PersonProvider>().listData;

    return EasyRefresh(
        header: RefreshHeader(),
        footer: RefreshFooter(),
        firstRefresh: true,
        child: Wrap(
            children: listData
                .map(
                  (item) => ProjectItem(
                    item,
                    index: listData.indexOf(item),
                  ),
                )
                .toList()),
        onLoad: () async {
          getData(context);
        },
        onRefresh: () async {
          getData(context, isReset: true);
        });
  }

  Widget _depList() {
    return TreeView(context.watch<PersonProvider>().projectListData,
        onChange: (data) {
      print(data);
    });
  }

  Future getData(BuildContext context, {bool isReset = false}) async {
    await context.read<PersonProvider>().getProjectData();
    return await context.read<PersonProvider>().getData(isReset: isReset);
  }

  void handleEditingComplete(BuildContext context, String keywords) async {
    await context.read<PersonProvider>().getData(key: keywords, isReset: true);
  }

  void handleCheck(bool isCheck) {}
}
