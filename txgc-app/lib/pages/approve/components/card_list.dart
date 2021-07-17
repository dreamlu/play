import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:txgc_app/components/refresh_footer.dart';
import 'package:txgc_app/components/refresh_header.dart';
import 'package:txgc_app/model/approve.dart';
import 'card_item.dart';

class CardList extends StatelessWidget {
  final bool isEmpty;
  final List<Approve> data;
  final String noDataDesc;
  final Widget Function(BuildContext context, Approve item) operation;
  final double cartTop;
  final String noDataImg;
  final Future Function(BuildContext context, bool isReset) getData;
  final List<Map> statusList;
  CardList(
    this.data,
    this.noDataDesc,
    this.noDataImg, {
    @required this.operation,
    this.isEmpty = false,
    this.getData,
    this.statusList,
    this.cartTop = 433,
  });
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
        header: RefreshHeader(),
        footer: RefreshFooter(),
        firstRefresh: true,
        emptyWidget: data.length == 0 ? _taskEmpty() : null,
        child: Container(
          child: Column(
              children: data
                  .map((item) => CardItem(
                        item,
                        statusList,
                        this.operation,
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
