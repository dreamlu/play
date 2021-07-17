import 'package:flutter/material.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:txgc_app/components/top_pic.dart';
import 'components/dash_report.dart';
import 'components/date_picker.dart';

class CanteenReportPage extends StatelessWidget {
  final Map<String, dynamic> params;
  CanteenReportPage(this.params);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFF7F7F7),
        child: Stack(
          children: [
            TopPic(
              'images/dining-pic.png',
            ),
            NavBack(),
            DatePicker(),
            DashReport()
          ],
        ),
      ),
    );
  }
}
