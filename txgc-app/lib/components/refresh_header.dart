import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class RefreshHeader extends ClassicalHeader {
  @override
  final Color infoColor = Color(0xFF009CFF);
  final Color textColor = Color(0xFF009CFF);
  final String refreshText = '下拉刷新';
  final String refreshedText = '加载完毕';
  final bool showInfo = false;
  final String refreshReadyText = '释放刷新';
  final String refreshingText = '刷新中...';
}
