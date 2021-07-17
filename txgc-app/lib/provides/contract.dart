import 'package:flutter/material.dart';
import 'package:txgc_app/model/pager.dart';
import 'package:txgc_app/model/resource.dart';
import 'package:txgc_app/services/contract.dart';
import 'package:txgc_app/services/cs_example.dart';
import 'package:txgc_app/services/request/base_resp.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/index.dart';

/// 合同管理
class ContractProvider with ChangeNotifier {
  List<Resource> listData = [];

  Pager pager =
      Pager.fromJson({'client_page': 1, 'every_page': 10, 'total_num': 10});

  /// 下拉赋值
  handleData(
    BaseResp _res,
  ) {
    var _data = _res.data;
    if (_data is List && _data.length != 0) {
      listData.addAll(
          _data.map<Resource>((_item) => Resource.fromJson(_item)).map((_item) {
        _item.isFolder = _item.typ == 0 ? true : false;
        _item.isContract = _item.typ == 1 ? true : false;
        _item.isCheck = true;
        return _item;
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
  Future getData({int status = 0, int pid, isReset: false}) async {
    Map<String, dynamic> payload = new Map<String, dynamic>.from({
      'project_id': Global.userCache.user.projectId,
      'clientPage': isReset ? 1 : pager.clientPage,
      'everyPage': pager.everyPage,
      'order': 'typ',
      'pid': pid,
      // 'project_person_id': Global.userCache.user.id,
    });
    if (isReset) {
      listData = [];
    }

    notifyListeners();
    await handleData((await searchContract(payload)));
  }

  /// 影像资料,创建
  /// [typ] // 0-4文件夹,5文件 // 0-3对应: 宣传,施工,隐蔽,其他,这时 Name 字段无效 // 4: 新建文件夹
  Future<bool> handleCreate() async {
    Map<String, dynamic> payload = new Map<String, dynamic>.from({
      'name': Global.formRecord['name'],
      'content': Global.formRecord['content'],
      'typ': Global.formRecord['typ'],
      'pid': Global.formRecord['pid'],
      'url': Global.formRecord['url'],
      'project_person_id': Global.userCache.user.id,
      'project_id': Global.userCache.user.projectId,
    });

    if (Global.formRecord['url'] != null) {
      List res = (await handleUploadMedia([Global.formRecord['url']]));
      payload['url'] = res[0]['rawUrl'];
      payload['name'] = res[0]['name'];
    }
    BaseResp res = await createContract(payload);
    if (res.status == '200') {
      Global.formRecord = {};
      return true;
    }
    return false;
  }

  /// 删除
  Future<bool> handleRemove() async {
    BaseResp res = await removeContract(Global.formRecord['id']);
    if (res.status == '200') {
      listData = listData
          .where((element) => element.id != Global.formRecord['id'])
          .toList();
      Global.formRecord = {};
      notifyListeners();
      return true;
    }
    return false;
  }
}
