import 'package:flutter/material.dart';
import 'package:txgc_app/model/client.dart';
import 'package:txgc_app/model/pager.dart';
import 'package:txgc_app/model/signature.dart';
import 'package:txgc_app/services/request/base_resp.dart';
import 'package:txgc_app/services/signature.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/index.dart';

/// 文件签认
class SignatureProvider with ChangeNotifier {
  List<Signature> listData = [];

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
          _data.map<Signature>((_item) => Signature.fromJson(_item)).toList());
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
    await handleData((await searchSignature(payload)));
  }

  /// 修改状态
  /// [status] 0未签认,1签认,2拒绝
  Future<bool> handleStatus() async {
    List<SignIds> signIds = Global.formRecord['sign_ids'];
    int index =
        signIds.indexWhere((element) => element.id == Global.userCache.user.id);
    signIds[index].reason = Global.formRecord['reason'];
    signIds[index].status = Global.formRecord['status'];

    BaseResp res = await updateSignature({
      'id': Global.formRecord['id'],
      'sign_ids': signIds.map((e) => e.toJson()).toList(),
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
    BaseResp res = await updateSignature(payload);

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
    BaseResp res = await createSignature(payload);
    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }

  /// 删除
  Future<bool> handleRemove() async {
    BaseResp res = await removeSignature(Global.formRecord['id']);
    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }
}
