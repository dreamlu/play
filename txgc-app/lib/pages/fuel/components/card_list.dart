import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:txgc_app/components/refresh_footer.dart';
import 'package:txgc_app/components/refresh_header.dart';
import 'package:txgc_app/model/car_record.dart';
import 'card_item.dart';

class CardList extends StatelessWidget {
  final bool isEmpty;
  final List<CarRecord> data;
  final String noDataDesc;
  final double cartTop;
  final List<Map> statusList;
  final String noDataImg;
  final Future Function(BuildContext context, bool isReset) getData;

  CardList(
    this.data,
    this.noDataDesc,
    this.noDataImg, {
    this.isEmpty = false,
    this.getData,
    this.statusList,
    this.cartTop = 310,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: cartTop.h,
        bottom: 0,
        left: 0,
        right: 0,
        child: EasyRefresh(
            header: RefreshHeader(),
            footer: RefreshFooter(),
            emptyWidget: data.length == 0 ? _taskEmpty() : null,
            firstRefresh: true,
            child: Container(
              margin: EdgeInsets.only(bottom: 30.h),
              child: Column(
                  children: data
                      .map((item) => CardItem(
                            item,
                            statusList,
                          ))
                      .toList()),
            ),
            onRefresh: () async {
              getData(context, true);
            }));
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
