import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DarkTab extends StatefulWidget {
  final List tabList;
  final EdgeInsetsGeometry padding;
  final void Function(int index) onTap; // tab点击触发函数
  final int index; // tab激活索引

  DarkTab(this.tabList, this.onTap, {this.index = 0, this.padding});
  @override
  _DarkTabState createState() => _DarkTabState();
}

class _DarkTabState extends State<DarkTab> {
  int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 103.h,
      width: 750.w,
      padding: widget.padding ?? EdgeInsets.only(top: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.tabList
            .map((item) => _darkTabItem(item['label'], item['value']))
            .toList(),
      ),
    );
  }

  Widget _darkTabItem(String name, int idx) {
    return InkWell(
      onTap: () {
        widget.onTap(idx);
        setState(() {
          _index = idx;
        });
      },
      child: Container(
        child: Text(
          name,
          style: TextStyle(
              color:
                  _index == idx ? Theme.of(context).primaryColor : Colors.black,
              fontSize: 30.sp),
        ),
        padding: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: _index == idx
                        ? Theme.of(context).primaryColor
                        : Color.fromRGBO(0, 0, 0, 0),
                    width: 3.0))),
      ),
    );
  }
}
