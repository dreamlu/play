import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class RefreshFooter extends ClassicalFooter {
  @override
  final Color infoColor = Color(0xFF009CFF);
  final Color textColor = Color(0xFF009CFF);
  final Color bgColor = Colors.white;
  final String loadedText = '加载完成';
  final String loadText = '下拉加载';
  final bool showInfo = false;
  final String loadReadyText = '正在加载中...';
  final String noMoreText = '已经到底啦';
  final String loadingText = '上拉加载';
}
