import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 顶部白底黑字导航栏
class TopAppBar extends StatelessWidget {
  final Widget child;
  final String title;
  final Color backgroundColor;
  final bool resizeToAvoidBottomPadding;
  final List<Widget> actions;
  TopAppBar(this.child, this.title,
      {this.backgroundColor = Colors.white,
      this.resizeToAvoidBottomPadding = false,
      this.actions});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Colors.white,
          appBarTheme: AppBarTheme(brightness: Brightness.light),
        ),
        child: Scaffold(
            resizeToAvoidBottomPadding: resizeToAvoidBottomPadding,
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              elevation: 0.0,
              title: Text(
                '$title',
                style: TextStyle(color: Color(0xFF000000), fontSize: 37.sp),
              ),
              actions: actions,
            ),
            backgroundColor: backgroundColor,
            body: child));
  }
}
