import 'package:flutter/material.dart';

class FolderProvider with ChangeNotifier {
  bool isRemove = false; // 删除操作
  int selectIdx = -1; // 选择索引

  handleRemove(bool isRemove) {
    this.isRemove = isRemove;
    notifyListeners();
  }

  handleSelect(int selectIdx) {
    this.selectIdx = selectIdx;
    notifyListeners();
  }
}
