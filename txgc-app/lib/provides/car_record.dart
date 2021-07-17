import 'package:flutter/material.dart';
import 'package:txgc_app/model/car_record.dart';
import 'package:txgc_app/model/pager.dart';
import 'package:txgc_app/services/car_record.dart';
import 'package:txgc_app/services/request/base_resp.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/index.dart';

/// 维修加油管理
class CarRecordProvider with ChangeNotifier {
  List<CarRecord> listData = [];

  Pager pager =
      Pager.fromJson({'client_page': 1, 'every_page': 10, 'total_num': 10});

  /// 下拉赋值
  handleData(
    BaseResp _res,
  ) {
    var _data = _res.data;
    if (_data is List && _data.length != 0) {
      listData.addAll(
          _data.map<CarRecord>((_item) => CarRecord.fromJson(_item)).toList());
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
      'project_id': Global.userCache.user.projectId,
      'clientPage': isReset ? 1 : pager.clientPage,
      'everyPage': pager.everyPage,
      'key': key,
    });
    if (isReset) {
      listData = [];
    }
    notifyListeners();
    await handleData((await searchCarRecord(payload)));
  }

  /// 任务交接,创建
  Future<bool> handleCreate() async {
    Map<String, dynamic> payload = new Map<String, dynamic>.from({
      'project_id': Global.userCache.user.projectId,
      'pr_car_driver': Global.userCache.user.user,
      'engine': Global.userCache.user.engineName,
      'plate': Global.formRecord['plate'],
      'car_type': Global.formRecord['car_type'],
      'typ': Global.formRecord['typ_add'] ?? false ? 0 : 1,
      'address': Global.formRecord['address'],
      'money': double.parse(Global.formRecord['money']),
      'img_url': await handleUploadMedia(Global.formRecord['img_url']),
    });
    BaseResp res = await createCarRecord(payload);
    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }

  /// 删除
  Future<bool> handleRemove() async {
    BaseResp res = await removeCarRecord(Global.formRecord['id']);
    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }
}
