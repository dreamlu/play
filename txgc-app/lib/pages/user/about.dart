import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'components/about_item.dart';
import 'components/copyright.dart';

final List menuList = [
  {'title': '隐私政策', "privacy": 'https://shop.wobangkj.com/yhf_privacy.pdf'},
  {
    'title': '切换账号',
  },
  {'title': '退出登录', "color": Color(0xFFFF000B)}
];

class UserAboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      Container(
        child: Image.asset('images/about.png'),
      ),
      Text(
        '通号北分施工管理系统',
        style: TextStyle(fontSize: 42.sp, color: Colors.black),
      ),
      Text(
        'Welcome to use the construction management \nsystem of the Beijing branch',
        style: TextStyle(fontSize: 20.sp, color: Color(0xFFB2B2B2)),
        textAlign: TextAlign.center,
      ),
    ];
    children.addAll(menuList.map((item) => AboutItem(item)).toList());

    return TopAppBar(
        Column(
          children: [
            Expanded(
              child: Column(
                children: children,
              ),
            ),
            Copyright()
          ],
        ),
        '设置');
  }
}
