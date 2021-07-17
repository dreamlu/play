import 'package:flutter/material.dart';
import 'package:txgc_app/model/client.dart';
import 'package:txgc_app/model/order.dart';
import 'package:txgc_app/model/pager.dart';
import 'package:txgc_app/services/order.dart';
import 'package:txgc_app/services/request/base_resp.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/index.dart';

/// 工单
class OrderProvider with ChangeNotifier {
  List<Order> listData = [];

  Client clientDetail = Client.fromJson({'type': 2});
  Pager pager =
      Pager.fromJson({'client_page': 1, 'every_page': 10, 'total_num': 10});

  /// 下拉赋值
  handleData(
    BaseResp _res,
  ) {
    var _data = _res.data;
    if (_data is List && _data.length != 0) {
      listData
          .addAll(_data.map<Order>((_item) => Order.fromJson(_item)).toList());
      pager = _res.pager;
      pager.clientPage++;
    }
    notifyListeners();
  }

  /// 分页
  ///
  /// [status] 0由我接收，1由我发起
  /// [isReset] 默认分页加载后新加数据到列表后面，当设置 [isReset] 为true时
  /// 则清空之前数据列表
  Future getData({int status = 0, isReset: false}) async {
    Map<String, dynamic> payload = new Map<String, dynamic>.from({
      'project_id': Global.userCache.user.projectId,
      'clientPage': isReset ? 1 : pager.clientPage,
      'everyPage': pager.everyPage,
    });
    if (isReset) {
      listData = [];
    }

    if (status == 1) {
      payload['project_person_id'] = Global.userCache.user.id;
    } else {
      payload['receive_id'] = Global.userCache.user.id;
    }

    notifyListeners();
    await handleData((await searchOrder(payload)));
  }

  /// 回复
  /// [status] 0进行中,1已完成,2任务预警,3已过期
  Future<bool> handleReply() async {
    BaseResp res = await updateOrder({
      'id': Global.formRecord['id'],
      'status': 1,
      'reply_content': Global.formRecord['reply_content'],
      'reply_img': await handleUploadMedia(Global.formRecord['reply_img']),
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
      'name': Global.formRecord['name'],
      'end_time': Global.formRecord['end_time'],
      'end_hour': int.parse(Global.formRecord['end_hour']),
      'content': Global.formRecord['content'],
      'img': await handleUploadMedia(Global.formRecord['img']),
      'receive_id': Global.formRecord['receive_id'],
      'is_sms': Global.formRecord['is_sms']
    });

    BaseResp res = await updateOrder(payload);

    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }

  /// 工单,创建
  Future<bool> handleCreate() async {
    Map<String, dynamic> payload = new Map<String, dynamic>.from({
      'name': Global.formRecord['name'],
      'end_time': Global.formRecord['end_time'],
      'end_hour': int.parse(Global.formRecord['end_hour']),
      'content': Global.formRecord['content'],
      'img': await handleUploadMedia(Global.formRecord['img']),
      'status': 0,
      'project_person_id': Global.userCache.user.id,
      'project_id': Global.userCache.user.projectId,
      'receive_id': Global.formRecord['receive_id'],
      'is_sms': Global.formRecord['is_sms']
    });
    BaseResp res = await createOrder(payload);
    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }

  /// 删除
  Future<bool> handleRemove() async {
    BaseResp res = await removeOrder(Global.formRecord['id']);
    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }
}
