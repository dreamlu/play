import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/refresh_footer.dart';
import 'package:txgc_app/components/refresh_header.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/components/top_search.dart';
import 'package:txgc_app/model/person.dart';
import 'package:txgc_app/provides/person.dart';
import 'package:provider/provider.dart';
import 'components/bottom_project_confirm.dart';
import 'components/project_item.dart';

class HanderOverProjectPage extends StatelessWidget {
  final Map<String, dynamic> params;
  HanderOverProjectPage(this.params);
  @override
  Widget build(BuildContext context) {
    return TopAppBar(
        Container(
          margin:
              EdgeInsets.only(left: 25.w, right: 25.w, top: 10.h, bottom: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    TopSearch(
                      hintText: '根据关键字搜索人员',
                      onEditingComplete: (String keywords) {
                        handleEditingComplete(context, keywords);
                      },
                    ),
                    Expanded(
                      child: _listScroll(context),
                    ),
                  ],
                ),
              ),
              BottomProjectConfirm( isMultiple: params['isMultiple'] ?? '0')
            ],
          ),
        ),
        '从项目部选择人员');
  }

  Widget _listScroll(BuildContext context) {
    final List<Person> listData = context.watch<PersonProvider>().listData;

    return EasyRefresh(
        header: RefreshHeader(),
        footer: RefreshFooter(),
        firstRefresh: true,
        child: Wrap(
            children: listData
                .map(
                  (item) => ProjectItem(item,
                      index: listData.indexOf(item),
                      isMultiple: params['isMultiple'] ?? '0'),
                )
                .toList()),
        onLoad: () async {
          getData(context);
        },
        onRefresh: () async {
          getData(context, isReset: true);
        });
  }

  Future getData(BuildContext context, {bool isReset = false}) async {
    return await context.read<PersonProvider>().getData(isReset: isReset);
  }

  void handleEditingComplete(BuildContext context, String keywords) async {
    await context.read<PersonProvider>().getData(key: keywords, isReset: true);
  }
}
