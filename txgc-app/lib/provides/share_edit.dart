import 'package:day/day.dart';
import 'package:flutter/material.dart';
import 'package:txgc_app/model/pager.dart';
import 'package:txgc_app/model/share_edit.dart';
import 'package:txgc_app/services/request/base_resp.dart';
import 'package:txgc_app/services/share_edit.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/index.dart';

/// 共享编辑
class ShareEditProvider with ChangeNotifier {
  List<ShareEdit> listData = [];

  Pager pager =
      Pager.fromJson({'client_page': 1, 'every_page': 10, 'total_num': 10});

  /// 下拉赋值
  handleData(
    BaseResp _res,
  ) {
    var _data = _res.data;
    if (_data is List && _data.length != 0) {
      listData.addAll(
          _data.map<ShareEdit>((_item) => ShareEdit.fromJson(_item)).toList());
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
    await handleData((await searchShareEdit(payload)));
  }

  /// 修改状态
  Future<bool> handleStatus() async {
    List<ReceiveIds> receiveIds = Global.formRecord['receive_ids'];
    List<ReceiveIds> receiveIdLog = Global.formRecord['receive_id_log'] ?? [];
    int index = receiveIds
        .indexWhere((element) => element.id == Global.userCache.user.id);
    int status = receiveIds[index].status;
    receiveIds[index].content = Global.formRecord['content'];
    receiveIds[index].status = 1;
    receiveIds[index].time = Day().format('YYYY-MM-DD HH:mm:ss');
    List receiveIdsJson = [];

    Map<String, dynamic> payload = new Map<String, dynamic>.from({
      'id': Global.formRecord['id'],
    });

    if (status == 0) {
      receiveIdsJson = receiveIds.map((e) => e.toJson()).toList();
      receiveIdsJson[index]['file'] =
          await handleUploadMedia(Global.formRecord['file']);
      payload['receive_id_log'] =
          Global.formRecord['receive_id_log'].map((e) => e.toJson()).toList();
      payload['receive_ids'] = receiveIdsJson;
    } else {
      int len = receiveIdLog.length;
      receiveIdLog.add(receiveIds[index]);
      receiveIdsJson = receiveIdLog.map((e) => e.toJson()).toList();
      receiveIdsJson[len]['file'] =
          await handleUploadMedia(Global.formRecord['file']);
      payload['receive_ids'] =
          Global.formRecord['receive_ids'].map((e) => e.toJson()).toList();
      payload['receive_id_log'] = receiveIdsJson;
    }

    BaseResp res = await updateShareEdit(payload);
    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }

  /// 共享编辑,创建
  Future<bool> handleCreate() async {
    Map<String, dynamic> payload = new Map<String, dynamic>.from({
      'name': Global.formRecord['name'],
      'content': Global.formRecord['content'],
      'typ': 0,
      'project_person_id': Global.userCache.user.id,
      'project_id': Global.userCache.user.projectId,
      'is_public': Global.formRecord['is_public'] == true ? 1 : 0,
      'is_ay': Global.formRecord['is_ay'] == true ? 1 : 0,
      'receive_ids': Global.formRecord['receive_ids']
          .map((item) => ({'id': item.id, 'name': item.name, 'status': 0}))
          .toList(),
    });
    BaseResp res = await createShareEdit(payload);
    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }

  /// 删除
  Future<bool> handleRemove() async {
    BaseResp res = await removeShareEdit(Global.formRecord['id']);
    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }
}
