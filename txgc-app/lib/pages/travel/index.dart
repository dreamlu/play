import 'package:flutter/material.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:txgc_app/components/pannel_list.dart';
import 'package:txgc_app/components/top_pic.dart';

class TravelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            TopPic(
              'images/vehicle-pic.png',
            ),
            NavBack(),
            PannelList(
              [
                new PannelListType('车辆管理', 'images/vehicle-mana.png', '/car'),
                new PannelListType('司机管理', 'images/driver-mana.png', '/driver'),
                new PannelListType(
                    '维修、加油上报汇总', 'images/vehicle-report.png', '/fuel'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
