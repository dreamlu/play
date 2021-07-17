import 'package:flutter/material.dart';
import 'package:txgc_app/components/dark_tab.dart';

class PosDarkTab extends StatelessWidget {
  final void Function(int index) onTap; // tab点击触发函数
  PosDarkTab(this.onTap);
  final List tabList = [
    {'label': '由我接收', 'value': 0},
    {'label': '由我发起', 'value': 1}
  ];
  @override
  Widget build(BuildContext context) {
    return DarkTab(this.tabList, onTap);
  }
}
