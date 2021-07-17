import 'package:flutter/material.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:txgc_app/components/top_pic.dart';
import 'components/carte_report.dart';
import 'components/weekend_tab.dart';

class CanteenCartePage extends StatelessWidget {
  final Map<String, dynamic> params;
  CanteenCartePage(this.params);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFF7F7F7),
        child: Stack(
          children: [
            TopPic(
              'images/weekly-dash-pic.png',
            ),
            NavBack(),
            WeekendTab(),
            CarteReport()
          ],
        ),
      ),
    );
  }
}
