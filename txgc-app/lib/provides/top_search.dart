import 'package:flutter/material.dart';

/// app底部搜索输入框
class TopSearchProvider with ChangeNotifier {
  String keywords;
  bool isCancel = true; // 是否取消搜索

  /// 储存搜索关键字
  handleKey(String key) {
    keywords = key;
    isCancel = false;
    notifyListeners();
  }

  /// 取消搜索
  handleCancel(bool key) {
    isCancel = key;
    keywords = null;
    notifyListeners();
  }
}
