import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum Types { info, primary, danger, warning, cancel, confirm }

final Map<Types, Color> btnColor = {
  Types.info: Color(0xFF009CFF),
  Types.primary: Color(0xFF00C86C),
  Types.danger: Color(0xFFFF6565),
  Types.warning: Color(0xFFFFA365),
  Types.cancel: Color(0xFFB2B2B2),
  Types.confirm: Color(0xFF00C86C)
};
final Map<Types, Color> btnShadowColor = {
  Types.info: Color(0x45005489),
  Types.primary: Color(0x4500893D),
  Types.danger: Color(0x45890000),
  Types.warning: Color(0x459C6535),
  Types.cancel: Color(0x45666666),
  Types.confirm: Color(0x4500893D),
};

class Btn extends StatelessWidget {
  final Types type;
  final String title;
  final EdgeInsetsGeometry margin;
  final bool isShow;
  final GestureTapCallback onTap;
  Btn(this.title, this.type, this.onTap, {this.margin, this.isShow = true});

  @override
  Widget build(BuildContext context) {
    return isShow
        ? InkWell(
            onTap: this.onTap,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
              margin: margin,
              decoration: BoxDecoration(
                  color: btnColor[type],
                  borderRadius: BorderRadius.all(Radius.circular(7.w)),
                  boxShadow: [
                    BoxShadow(
                        color: btnShadowColor[type],
                        offset: Offset(2.0, 0.0),
                        blurRadius: 5.0)
                  ]),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white, fontSize: 26.sp, height: 1.0),
              ),
            ),
          )
        : Container();
  }
}

class BottomBtn extends StatelessWidget {
  final String title;
  final Color color;
  final String desc;
  final int width;
  final GestureTapCallback onTap;
  BottomBtn(this.title, this.color, {this.desc, this.onTap, this.width = 340});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width.w,
        height: 90.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            border: Border.all(width: 2.w, color: color)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(color: color, fontSize: 28.sp),
            ),
            desc != null
                ? Text(
                    desc,
                    style: TextStyle(color: color, fontSize: 18.sp),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
