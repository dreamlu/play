import 'package:day/day.dart';
import 'package:flutter/material.dart';
import 'package:txgc_app/model/meeting.dart';
import 'package:txgc_app/model/pager.dart';
import 'package:txgc_app/services/meeting.dart';
import 'package:txgc_app/services/request/base_resp.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/index.dart';

/// 会议
class MeetingProvider with ChangeNotifier {
  List<Meeting> listData = [];

  Pager pager =
      Pager.fromJson({'client_page': 1, 'every_page': 10, 'total_num': 10});

  /// 下拉赋值
  handleData(
    BaseResp _res,
  ) {
    var _data = _res.data;
    if (_data is List && _data.length != 0) {
      listData.addAll(
          _data.map<Meeting>((_item) => Meeting.fromJson(_item)).map((e) {
        if (e.endTime != '' && Day().isAfter(Day.fromString(e.endTime))) {
          e.status = 2;
        } else if (Day().isAfter(Day.fromString(e.startTime))) {
          e.status = 1;
        } else {
          e.status = 0;
        }
        return e;
      }).toList());
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
      payload['join_id'] = Global.userCache.user.id;
    }

    notifyListeners();
    await handleData((await searchMeeting(payload)));
  }

  /// 修改状态
  Future<bool> handleStatus() async {
    BaseResp res = await updateMeeting({
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
    BaseResp res = await updateMeeting(payload);

    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }

  /// 会议,创建
  Future<bool> handleCreate() async {
    List<JoinIds> joinIds = [];

    if (Global.formRecord['join_ids'] is List) {
      Global.formRecord['join_ids'].forEach((e) => joinIds.add(
          JoinIds(phone: e.phone, name: e.name, id: e.id, status: 0, isR: 0)));
    }

    if (Global.formRecord['record_id'] != null) {
      joinIds.add(JoinIds(
          name: Global.formRecord['record_name'],
          id: Global.formRecord['record_id'],
          phone: Global.formRecord['record_phone'],
          status: 0,
          isR: 1));
    }

    Map<String, dynamic> payload = new Map<String, dynamic>.from({
      'name': Global.formRecord['name'],
      'start_time': Global.formRecord['start_time'],
      'content': Global.formRecord['content'],
      'join_ids': joinIds.map((e) => e.toJson()).toList(),
      'project_person_id': Global.userCache.user.id,
      'project_id': Global.userCache.user.projectId,
      'typ': Global.formRecord['typ'] == true ? 1 : 0,
      'remark': Global.formRecord['remark'],
      'remind': Global.formRecord['is_remind']
          ? int.parse(Global.formRecord['remind'])
          : 0,
      'plat': Global.formRecord['plat']
    });
    BaseResp res = await createMeeting(payload);
    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }

  /// 删除
  Future<bool> handleRemove() async {
    BaseResp res = await removeMeeting(Global.formRecord['id']);
    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }
}
