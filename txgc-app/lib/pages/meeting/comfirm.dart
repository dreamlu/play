import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/utils/global.dart';
import 'components/confirm_item.dart';

class MeetingComfirmPage extends StatelessWidget {
  final Map<String, dynamic> params;
  MeetingComfirmPage(this.params);

  @override
  Widget build(BuildContext context) {
    return TopAppBar(
        Container(
            margin: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 20.h),
            child: Theme(
              data: Theme.of(context).copyWith(
                primaryColor: Color(0xFF009CFF),
              ),
              child: Column(children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: _projectList(),
                      )
                    ],
                  ),
                ),
              ]),
            )),
        '查看人员确认情况');
  }

  Widget _projectList() {
    return SingleChildScrollView(
        child: Wrap(
            children: Global.formRecord['join_ids']
                .map<Widget>((e) => ConfirmItem(e))
                .toList()));
  }

  void handleCheck(bool isConfirm) {}
}
