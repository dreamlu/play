import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:txgc_app/routers/application.dart';
import 'pannel_list.dart';

class PannelItem extends StatelessWidget {
  final PannelListType item;

  PannelItem(this.item);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(
          context,
          item.url,
          transition: TransitionType.native,
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 25.h, right: 20.w),
        width: 340.w,
        height: 415.h,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: Offset(0, 3.w),
              blurRadius: 10.w,
              color: Color(0x45999999))
        ], color: Colors.white, borderRadius: BorderRadius.circular(10.w)),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 22.h),
              alignment: Alignment.center,
              child: Image.asset(
                item.icon,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 18.h),
              alignment: Alignment.center,
              child: Text(
                item.label,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
