import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:txgc_app/model/user_login.dart';

class Global {
  static SharedPreferences prefs;

  static Map formRecord = {};

  static double areaHeight = 0; // 底部安全区域

  static double pixelRatio = 0; // dpr

  static double fullHeight = 0; // 全屏高度

  static double statusBarHeight = 0; // 顶部状态栏, 随着刘海屏会增高

  static String token = ''; // token

  static UserLogin userCache = UserLogin.fromJson({});

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    prefs = await SharedPreferences.getInstance();
    var _profile = prefs.getString("USER_CACHE");
    if (_profile != null) {
      try {
        userCache = UserLogin.fromJson(jsonDecode(_profile));
        print(userCache);
      } catch (e) {
        print(e);
      }
    }
  }

  // 持久化Profile信息
  static saveProfile(UserLogin data) =>
      prefs.setString("USER_CACHE", jsonEncode(data.toJson()));
}
