import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'canteen_tabel.dart';

class CarteReport extends StatefulWidget {
  @override
  _CarteReportState createState() => _CarteReportState();
}

class _CarteReportState extends State<CarteReport> {
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(color: Color(0xFF000000), fontSize: 28.sp);

    return CanteenTabel(
      '食堂菜单',
      [
        '就餐时间',
        '菜品',
      ],
      [
        DataRow(cells: [
          DataCell(Text('早餐', style: style)),
          DataCell(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://via.placeholder.com/217.png/09f/fff',
                  width: 217.w,
                  height: 217.w,
                  fit: BoxFit.cover,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.w),
                  child: Text('馒头、肉包、菜包、油条、豆浆、白粥、咸菜', style: style),
                )
              ],
            ),
          ),
        ]),
        DataRow(cells: [
          DataCell(Text('午餐', style: style)),
          DataCell(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://via.placeholder.com/217.png/09f/fff',
                  width: 217.w,
                  height: 217.w,
                  fit: BoxFit.cover,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.w),
                  child: Text('馒头、肉包、菜包、油条、豆浆、白粥、咸菜', style: style),
                )
              ],
            ),
          ),
        ]),
        DataRow(cells: [
          DataCell(Text('晚餐', style: style)),
          DataCell(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://via.placeholder.com/217.png/09f/fff',
                  width: 217.w,
                  height: 217.w,
                  fit: BoxFit.cover,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.w),
                  child: Text('馒头、肉包、菜包、油条、豆浆、白粥、咸菜', style: style),
                )
              ],
            ),
          ),
        ]),
      ],
      dataRowHeight: 352.h,
    );
  }
}
