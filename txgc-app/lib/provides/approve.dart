import 'package:flutter/material.dart';
import 'package:txgc_app/model/approve.dart';
import 'package:txgc_app/model/client.dart';
import 'package:txgc_app/model/pager.dart';
import 'package:txgc_app/model/signature.dart';
import 'package:txgc_app/services/approve.dart';
import 'package:txgc_app/services/request/base_resp.dart';
import 'package:txgc_app/utils/global.dart';

/// 文件签认
class ApproveProvider with ChangeNotifier {
  List<Approve> listData = [];

  Client clientDetail = Client.fromJson({'type': 2});
  Pager pager =
      Pager.fromJson({'client_page': 1, 'every_page': 10, 'total_num': 10});

  /// 下拉赋值
  handleData(
    BaseResp _res,
  ) {
    var _data = _res.data;
    if (_data is List && _data.length != 0) {
      listData.addAll(
          _data.map<Approve>((_item) => Approve.fromJson(_item)).toList());
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
  Future getData({isReset: false}) async {
    Map<String, dynamic> payload = new Map<String, dynamic>.from({
      'project_id': Global.userCache.user.projectId,
      'clientPage': isReset ? 1 : pager.clientPage,
      'sign_id': Global.userCache.user.id,
      'everyPage': pager.everyPage,
    });
    if (isReset) {
      listData = [];
    }

    notifyListeners();
    await handleData((await searchApprove(payload)));
  }

  /// 修改状态
  /// [status] 0未签认,1签认,2拒绝
  Future<bool> handleStatus() async {
    List<SignIds> signIds = Global.formRecord['sign_ids'];
    int index =
        signIds.indexWhere((element) => element.id == Global.userCache.user.id);
    signIds[index].reason = Global.formRecord['reason'];
    signIds[index].status = Global.formRecord['status'];

    BaseResp res = await updateApprove({
      'id': Global.formRecord['id'],
      'sign_ids': signIds.map((e) => e.toJson()).toList(),
    });
    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }
}
