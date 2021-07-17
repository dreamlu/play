import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'pannel_item.dart';

class PannelListType {
  String label;
  String icon;
  String url;
  PannelListType(this.label, this.icon, this.url);
}

class PannelList extends StatelessWidget {
  final List<PannelListType> data;

  PannelList(
    this.data,
  );
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 300.h,
      bottom: 0,
      left: 0,
      right: 0,
      child: SingleChildScrollView(
          child: Center(
        child: Wrap(
            children: data
                .map((item) => PannelItem(
                      item,
                    ))
                .toList()),
      )),
    );
  }
}
