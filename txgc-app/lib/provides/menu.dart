import 'package:flutter/material.dart';

class MenuProvider with ChangeNotifier {
  int menuIdx = 0;

  handleMenu(int index) {
    menuIdx = index;
    notifyListeners();
  }
}
