import 'package:flutter/material.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:txgc_app/components/nav_filtter.dart';
import 'package:txgc_app/components/pannel_list.dart';
import 'package:txgc_app/components/top_pic.dart';

class CanteenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            TopPic(
              'images/canteen-pic.png',
            ),
            NavBack(),
            NavFilter(),
            PannelList(
              [
                new PannelListType('食堂就餐统计报表', 'images/canteen-report.png',
                    '/canteen/report?id=0'),
                new PannelListType(
                    '每周食堂菜品', 'images/canteen-dash.png', '/canteen/carte?id=0'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
