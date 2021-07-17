import 'package:flutter/material.dart';
import 'package:txgc_app/model/pager.dart';
import 'package:txgc_app/model/task.dart';
import 'package:txgc_app/services/request/base_resp.dart';
import 'package:txgc_app/services/task.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/index.dart';

/// 任务交接
class TaskProvider with ChangeNotifier {
  List<Task> listData = [];

  Pager pager =
      Pager.fromJson({'client_page': 1, 'every_page': 10, 'total_num': 10});

  /// 下拉赋值
  handleData(
    BaseResp _res,
  ) {
    var _data = _res.data;
    if (_data is List && _data.length != 0) {
      listData
          .addAll(_data.map<Task>((_item) => Task.fromJson(_item)).toList());
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
    await handleData((await searchTask(payload)));
  }

  /// 修改状态
  Future<bool> handleStatus() async {
    BaseResp res = await updateTask({
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
      'name': Global.formRecord['name'],
      'content': Global.formRecord['content'],
      'img': await handleUploadMedia(Global.formRecord['img']),
      'file': Global.formRecord['file'],
      'receive_id': Global.formRecord['receive_id']
    });
    if (Global.formRecord['file'] is List) {
      payload['file'] = [];
      Global.formRecord['file'].forEach((item) {
        payload['file'].add({'name': item.name, 'rawUrl': item.rawUrl});
      });
    }
    BaseResp res = await updateTask(payload);

    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }

  /// 任务交接,创建
  Future<bool> handleCreate() async {
    Map<String, dynamic> payload = new Map<String, dynamic>.from({
      'name': Global.formRecord['name'],
      'content': Global.formRecord['content'],
      'img': await handleUploadMedia(Global.formRecord['img']),
      'status': 0,
      'project_person_id': Global.userCache.user.id,
      'project_id': Global.userCache.user.projectId,
      'receive_id': Global.formRecord['receive_id']
    });
    BaseResp res = await createTask(payload);
    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }

  /// 删除
  Future<bool> handleRemove() async {
    BaseResp res = await removeTask(Global.formRecord['id']);
    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }
}
