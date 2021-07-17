import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/routers/application.dart';

class PannelList extends StatelessWidget {
  final String title;
  final String icon;
  final List<Widget> data;
  final String navPath;
  PannelList(
      {@required this.title,
      @required this.icon,
      this.data = const [],
      this.navPath})
      : assert(title != null && icon != null);
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [_title(context)];

    children.addAll(data);

    return Wrap(
      children: children,
    );
  }

  Widget _title(BuildContext context) {
    return Container(
      width: 700.w,
      margin: EdgeInsets.only(bottom: 35.h, top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Image.asset(icon),
                Container(
                  margin: EdgeInsets.only(left: 12.w),
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: 32.sp),
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Application.router.navigateTo(context, navPath,
                  transition: TransitionType.native);
            },
            child: Container(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10.w),
                    child: Text(
                      '查看更多',
                      style:
                          TextStyle(color: Color(0xFF999999), fontSize: 29.sp),
                    ),
                  ),
                  Image.asset('images/right-tri.png'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
