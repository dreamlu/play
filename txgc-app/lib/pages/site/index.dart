import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/components/nav_back.dart';
import 'package:txgc_app/components/top_pic.dart';
import 'package:txgc_app/components/top_search.dart';
import 'package:txgc_app/provides/site.dart';
import 'components/card_list.dart';
import 'package:provider/provider.dart';

class SitePage extends StatefulWidget {
  @override
  _SitePageState createState() => _SitePageState();
}

class _SitePageState extends State<SitePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            TopPic(
              'images/site-pic.png',
            ),
            NavBack(),
            Positioned(
              left: 25.w,
              right: 25.w,
              top: 330.h,
              child: TopSearch(
                hintText: '根据名称搜索站点',
                onEditingComplete: (String keywords) {
                  handleEditingComplete(context, keywords);
                },
              ),
            ),
            CardList(
              context.watch<SiteProvider>().listData,
              '暂无站点信息',
              'images/receive-empty.png',
              getData: getData,
            ),
          ],
        ),
      ),
    );
  }

  Future getData(BuildContext context, bool isReset) async {
    await context.read<SiteProvider>().getData(isReset: isReset);
  }

  handleEditingComplete(BuildContext context, String keywords) async {
    await context.read<SiteProvider>().getData(key: keywords, isReset: true);
  }
}
