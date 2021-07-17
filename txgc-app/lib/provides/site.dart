import 'package:flutter/material.dart';
import 'package:txgc_app/model/pager.dart';
import 'package:txgc_app/model/car.dart';
import 'package:txgc_app/model/site.dart';
import 'package:txgc_app/services/request/base_resp.dart';
import 'package:txgc_app/services/car.dart';
import 'package:txgc_app/services/site.dart';
import 'package:txgc_app/utils/global.dart';

/// 站点管理
class SiteProvider with ChangeNotifier {
  List<Site> listData = [];

  Pager pager =
      Pager.fromJson({'client_page': 1, 'every_page': 10, 'total_num': 10});

  /// 下拉赋值
  handleData(
    BaseResp _res,
  ) {
    var _data = _res.data;
    if (_data is List && _data.length != 0) {
      listData.addAll(_data.map<Site>((_item) => Site.fromJson(_item)).toList());
      pager = _res.pager;
      pager.clientPage++;
    }
    notifyListeners();
  }

  /// 分页
  ///
  /// [isReset] 默认分页加载后新加数据到列表后面，当设置 [isReset] 为true时
  /// 则清空之前数据列表
  Future getData({isReset: false, key: ''}) async {
    Map<String, dynamic> payload = new Map<String, dynamic>.from({
      'clientPage': isReset ? 1 : pager.clientPage,
      'everyPage': pager.everyPage,
      'key': key,
    });
    if (isReset) {
      listData = [];
    }
    notifyListeners();
    await handleData((await searchSite(payload)));
  }
}
