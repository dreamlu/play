import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:txgc_app/components/refresh_footer.dart';
import 'package:txgc_app/components/refresh_header.dart';
import 'package:txgc_app/model/car_log.dart';

class LogList extends StatelessWidget {
  final bool isEmpty;
  final List<CarLog> data;
  final String noDataDesc;
  final int tabIdx;
  final Future Function(BuildContext context, bool isReset) getData;

  LogList(
    this.data,
    this.noDataDesc,
    this.tabIdx, {
    this.isEmpty = false,
    this.getData,
  });

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
        header: RefreshHeader(),
        footer: RefreshFooter(),
        emptyWidget: data.length == 0 ? _taskEmpty() : null,
        firstRefresh: true,
        child: Container(
          child: Column(
            children: data.map((item) => _projectItem(item)).toList(),
          ),
        ),
        onRefresh: () async {
          getData(context, true);
        });
  }

  Widget _projectItem(CarLog item) {
    return Container(
      width: 700.w,
      margin: EdgeInsets.only(top: 20.h),
      padding: EdgeInsets.all(30.w),
      decoration: BoxDecoration(
          color: Color(0xFFF5F6FA), borderRadius: BorderRadius.circular(10.w)),
      child: Wrap(
        children: [
          Container(
            child: Text(
              tabIdx == 0 ? item.engineName : item.carDriver,
              style: TextStyle(color: Colors.black, fontSize: 32.sp),
            ),
          ),
          _projectDate(item)
        ],
      ),
    );
  }

  Widget _projectDate(CarLog item) {
    return Container(
      margin: EdgeInsets.only(top: 19.h),
      child: Row(
        children: [
          Image.asset('images/time.png'),
          Container(
            margin: EdgeInsets.only(left: 10.w),
            child: Text(
              '所在时间：${item.startTime}至${item.endTime == '' ? '今日' : item.endTime}',
              style: TextStyle(color: Color(0xFF999999), fontSize: 24.sp),
            ),
          )
        ],
      ),
    );
  }

  Widget _taskEmpty() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
