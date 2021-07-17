import 'package:oktoast/oktoast.dart';

class Verify {
  ///手机号验证
  ///
  /// [str] 验证字符串
  /// [msg] 验证失败弹窗
  static bool isChinaPhone(String str, String msg) {
    bool isMatch = RegExp(r"^(?:(?:\+|00)86)?1\d{10}$").hasMatch(str);
    if (!isMatch && msg != null) {
      showToast(msg);
    }
    return isMatch;
  }
}
