import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/utils/global.dart';

class CanteenTabel extends StatefulWidget {
  final String title;
  final bool isSubTitle;
  final List<String> headerTitle;
  final List<DataRow> rows;
  final double dataRowHeight;
  CanteenTabel(this.title, this.headerTitle, this.rows,
      {this.isSubTitle = false, this.dataRowHeight = 48.0});
  @override
  _CanteenTabelState createState() => _CanteenTabelState();
}

class _CanteenTabelState extends State<CanteenTabel> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 425.h,
        child: Container(
          width: 700.w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.w),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 3.w),
                    blurRadius: 10.w,
                    color: Color(0x45999999))
              ]),
          margin: EdgeInsets.only(left: 25.w, right: 25.w),
          child: Wrap(
            children: [
              _dataTitle(),
              widget.isSubTitle ? _dataSubtitle() : Container(),
              _dataWrap()
            ],
          ),
        ));
  }

  Widget _dataSubtitle() {
    TextStyle style = TextStyle(color: Color(0xFF999999), fontSize: 24.sp);

    return Container(
      margin: EdgeInsets.only(left: 31.w, right: 31.w, bottom: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '施工项目部一',
            style: style,
          ),
          Text(
            '早餐：2.00元',
            style: style,
          ),
          Text(
            '午餐：6.50元',
            style: style,
          ),
        ],
      ),
    );
  }

  Widget _dataTitle() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 32.h, bottom: 29.h),
      child: Text(
        widget.title,
        style: TextStyle(color: Color(0xFF000000), fontSize: 36.sp),
      ),
    );
  }

  Widget _dataWrap() {
    return Container(
      height: (Global.fullHeight - 650 - Global.areaHeight).h,
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, child: _dataTable())),
    );
  }

  Widget _dataTable() {
    TextStyle style = TextStyle(color: Color(0xFF000000), fontSize: 28.sp);
    return DataTable(
        showBottomBorder: false,
        dividerThickness: 0,
        headingRowColor:
            MaterialStateColor.resolveWith((states) => Color(0xFFF3FAFF)),
        headingTextStyle: style,
        dataRowHeight: widget.dataRowHeight,
        columns: widget.headerTitle.map((name) => _tabelHeader(name)).toList(),
        rows: widget.rows);
  }

  DataColumn _tabelHeader(String label) {
    return DataColumn(
        label: Container(
      child: Text(
        '$label',
      ),
    ));
  }
}
