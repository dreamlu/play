import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/model/share_edit.dart';
import 'package:txgc_app/pages/editor/components/panel_item.dart';

class PanelList extends StatelessWidget {
  final bool isEmpty;
  final List<ReceiveIds> data;
  final int tabIdx;
  final String noDataDesc;
  final String isView;
  final String noDataImg;
  final Future Function(BuildContext context, bool isReset) getData;
  PanelList(this.data, this.noDataDesc, this.noDataImg,
      {this.isEmpty = false, this.getData, this.tabIdx, this.isView});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 750.w,
      padding: EdgeInsets.only(top: 25.h),
      color: Color(0xFFF7F7F7),
      child: data.length == 0
          ? _taskEmpty()
          : Column(
              children:
                  data.map((item) => PanelItem(item, this.tabIdx)).toList()),
    );
  }

  Widget _taskEmpty() {
    return Container(
      height: 500.h,
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
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
