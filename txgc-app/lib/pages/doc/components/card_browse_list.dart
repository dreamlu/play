import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:txgc_app/components/refresh_footer.dart';
import 'package:txgc_app/components/refresh_header.dart';
import 'package:txgc_app/model/file_receive.dart';
import 'card_browse_item.dart';

class CardBrowseList extends StatelessWidget {
  final bool isEmpty;
  final List<ReceiveIds> data;
  final String noDataDesc;
  final String noDataImg;
  final Future Function(BuildContext context, bool isReset) getData;
  final List<Map> statusList;
  CardBrowseList(
    this.data,
    this.noDataDesc,
    this.noDataImg, {
    this.isEmpty = false,
    this.getData,
    this.statusList,
  });
  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? _taskEmpty()
        : EasyRefresh(
            header: RefreshHeader(),
            footer: RefreshFooter(),
            child: Container(
              child: Column(
                  children: data
                      .map((item) => CardBrowseItem(
                            item,
                            statusList,
                          ))
                      .toList()),
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
