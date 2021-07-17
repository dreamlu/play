import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf_flutter/pdf_flutter.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:txgc_app/utils/global.dart';

class AboutItem extends StatelessWidget {
  final Map item;
  AboutItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 750.w,
      padding:
          EdgeInsets.only(left: 77.w, right: 77.w, top: 30.h, bottom: 30.h),
      child: InkWell(
        onTap: () {
          switch (item['title']) {
            case '隐私政策':
              _navigateToPage(
                context,
                title: "隐私政策",
                child: PDF.network(
                  item['privacy'],
                ),
              );
              break;
            case '切换账号':
              Application.router.navigateTo(context, '/login',
                  transition: TransitionType.native);
              break;
            case '退出登录':
              Global.userCache.id = null;
              Global.saveProfile(Global.userCache);
              Application.router.navigateTo(context, '/login',
                  transition: TransitionType.native);
              break;
            default:
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${item['title']}',
              style: TextStyle(
                  color: item['color'] ?? Color(0xFF000000), fontSize: 32.sp),
            ),
            Container(
              padding: EdgeInsets.only(left: 14.w),
              child: Image.asset('images/right-tri.png'),
            )
          ],
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, {String title, Widget child}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TopAppBar(
          Center(child: child),
          title,
        ),
      ),
    );
  }
}
