import 'package:flutter/material.dart';
import 'package:txgc_app/model/client.dart';
import 'package:txgc_app/model/file_receive.dart';
import 'package:txgc_app/model/pager.dart';
import 'package:txgc_app/services/request/base_resp.dart';
import 'package:txgc_app/services/file_receive.dart';
import 'package:txgc_app/utils/global.dart';

/// 文件接收
class FileReceiveProvider with ChangeNotifier {
  List<FileReceive> listData = [];

  Client clientDetail = Client.fromJson({'type': 2});
  Pager pager =
  Pager.fromJson({'client_page': 1, 'every_page': 10, 'total_num': 10});

  /// 下拉赋值
  handleData(
      BaseResp _res,
      ) {
    var _data = _res.data;
    if (_data is List && _data.length != 0) {
      listData.addAll(_data
          .map<FileReceive>((_item) => FileReceive.fromJson(_item))
          .toList());
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
    await handleData((await searchFileReceive(payload)));
  }

  /// 修改状态
  Future<bool> handleStatus() async {
    List<ReceiveIds> receiveIds = Global.formRecord['receive_ids'];
    int index = receiveIds
        .indexWhere((element) => element.id == Global.userCache.user.id);
    receiveIds[index].status = Global.formRecord['status'];
    receiveIds[index].time = Global.formRecord['time'];
    BaseResp res = await updateFileReceive({
      'id': Global.formRecord['id'],
      'receive_ids': receiveIds.map((e) => e.toJson()).toList(),
    });
    if (res.status == '200') {
      return true;
    }
    return false;
  }
}
