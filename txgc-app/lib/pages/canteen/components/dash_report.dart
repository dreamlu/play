import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'canteen_tabel.dart';

class DashReport extends StatefulWidget {
  @override
  _DashReportState createState() => _DashReportState();
}

class _DashReportState extends State<DashReport> {
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(color: Color(0xFF000000), fontSize: 28.sp);

    return CanteenTabel(
      '食堂就餐统计报表',
      ['姓名', '早餐', '午餐', '饭费合计'],
      [
        DataRow(cells: [
          DataCell(Wrap(
            direction: Axis.vertical,
            children: [
              Text('李安', style: style),
              Text('序号：2021',
                  style: TextStyle(color: Color(0xFF999999), fontSize: 24.sp))
            ],
          )),
          DataCell(Text('18次', style: style)),
          DataCell(Text('18次', style: style)),
          DataCell(Text('147.00元',
              style: TextStyle(color: Color(0xFFFF4747), fontSize: 28.sp))),
        ]),
        DataRow(cells: [
          DataCell(Wrap(
            direction: Axis.vertical,
            children: [
              Text('李安', style: style),
              Text('序号：2021',
                  style: TextStyle(color: Color(0xFF999999), fontSize: 24.sp))
            ],
          )),
          DataCell(Text('18次', style: style)),
          DataCell(Text('18次', style: style)),
          DataCell(Text('147.00元',
              style: TextStyle(color: Color(0xFFFF4747), fontSize: 28.sp))),
        ]),
        DataRow(cells: [
          DataCell(Wrap(
            direction: Axis.vertical,
            children: [
              Text('李安', style: style),
              Text('序号：2021',
                  style: TextStyle(color: Color(0xFF999999), fontSize: 24.sp))
            ],
          )),
          DataCell(Text('18次', style: style)),
          DataCell(Text('18次', style: style)),
          DataCell(Text('147.00元',
              style: TextStyle(color: Color(0xFFFF4747), fontSize: 28.sp))),
        ]),
        DataRow(cells: [
          DataCell(Wrap(
            direction: Axis.vertical,
            children: [
              Text('李安', style: style),
              Text('序号：2021',
                  style: TextStyle(color: Color(0xFF999999), fontSize: 24.sp))
            ],
          )),
          DataCell(Text('18次', style: style)),
          DataCell(Text('18次', style: style)),
          DataCell(Text('147.00元',
              style: TextStyle(color: Color(0xFFFF4747), fontSize: 28.sp))),
        ]),
        DataRow(cells: [
          DataCell(Wrap(
            direction: Axis.vertical,
            children: [
              Text('李安', style: style),
              Text('序号：2021',
                  style: TextStyle(color: Color(0xFF999999), fontSize: 24.sp))
            ],
          )),
          DataCell(Text('18次', style: style)),
          DataCell(Text('18次', style: style)),
          DataCell(Text('147.00元',
              style: TextStyle(color: Color(0xFFFF4747), fontSize: 28.sp))),
        ]),
        DataRow(cells: [
          DataCell(Wrap(
            direction: Axis.vertical,
            children: [
              Text('李安', style: style),
              Text('序号：2021',
                  style: TextStyle(color: Color(0xFF999999), fontSize: 24.sp))
            ],
          )),
          DataCell(Text('18次', style: style)),
          DataCell(Text('18次', style: style)),
          DataCell(Text('147.00元',
              style: TextStyle(color: Color(0xFFFF4747), fontSize: 28.sp))),
        ]),
        DataRow(cells: [
          DataCell(Wrap(
            direction: Axis.vertical,
            children: [
              Text('李安', style: style),
              Text('序号：2021',
                  style: TextStyle(color: Color(0xFF999999), fontSize: 24.sp))
            ],
          )),
          DataCell(Text('18次', style: style)),
          DataCell(Text('18次', style: style)),
          DataCell(Text('147.00元',
              style: TextStyle(color: Color(0xFFFF4747), fontSize: 28.sp))),
        ]),
        DataRow(cells: [
          DataCell(Wrap(
            direction: Axis.vertical,
            children: [
              Text('李安', style: style),
              Text('序号：2021',
                  style: TextStyle(color: Color(0xFF999999), fontSize: 24.sp))
            ],
          )),
          DataCell(Text('18次', style: style)),
          DataCell(Text('18次', style: style)),
          DataCell(Text('147.00元',
              style: TextStyle(color: Color(0xFFFF4747), fontSize: 28.sp))),
        ]),
        DataRow(cells: [
          DataCell(Wrap(
            direction: Axis.vertical,
            children: [
              Text('李安', style: style),
              Text('序号：2021',
                  style: TextStyle(color: Color(0xFF999999), fontSize: 24.sp))
            ],
          )),
          DataCell(Text('18次', style: style)),
          DataCell(Text('18次', style: style)),
          DataCell(Text('147.00元',
              style: TextStyle(color: Color(0xFFFF4747), fontSize: 28.sp))),
        ])
      ],
      isSubTitle: true,
    );
  }
}
