import 'package:flutter/material.dart';
import 'package:txgc_app/model/pager.dart';
import 'package:txgc_app/model/car.dart';
import 'package:txgc_app/services/request/base_resp.dart';
import 'package:txgc_app/services/car.dart';
import 'package:txgc_app/utils/global.dart';

/// 通知管理
class CarProvider with ChangeNotifier {
  List<Car> listData = [];

  Pager pager =
      Pager.fromJson({'client_page': 1, 'every_page': 10, 'total_num': 10});

  /// 下拉赋值
  handleData(
    BaseResp _res,
  ) {
    var _data = _res.data;
    if (_data is List && _data.length != 0) {
      listData.addAll(_data.map<Car>((_item) => Car.fromJson(_item)).toList());
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
    await handleData((await searchCar(payload)));
  }

  /// 修改状态
  Future<bool> handleStatus() async {
    BaseResp res = await updateCar({
      'id': Global.formRecord['id'],
      'status': Global.formRecord['status'],
      'reason': Global.formRecord['reason'],
    });
    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }

  /// 修改
  Future<bool> handleUpdate() async {
    Map<String, dynamic> payload = new Map<String, dynamic>.from({
      'id': Global.formRecord['id'],
      'project_id': Global.userCache.user.projectId,
      'engine_id': Global.formRecord['engine_id'],
      'plate': Global.formRecord['plate'],
      'status': Global.formRecord['status'],
      'typ': Global.formRecord['typ']
    });
    if (Global.formRecord['file'] is List) {
      payload['file'] = [];
      Global.formRecord['file'].forEach((item) {
        payload['file'].add({'name': item.name, 'rawUrl': item.rawUrl});
      });
    }
    BaseResp res = await updateCar(payload);

    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }

  /// 任务交接,创建
  Future<bool> handleCreate() async {
    Map<String, dynamic> payload = new Map<String, dynamic>.from({
      'project_id': Global.userCache.user.projectId,
      'engine_id': Global.formRecord['engine_id'],
      'plate': Global.formRecord['plate'],
      'status': Global.formRecord['status'],
      'typ': Global.formRecord['typ'],
    });
    BaseResp res = await createCar(payload);
    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }

  /// 删除
  Future<bool> handleRemove() async {
    BaseResp res = await removeCar(Global.formRecord['id']);
    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }
}
