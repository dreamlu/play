import 'package:flutter/material.dart';
import 'package:txgc_app/model/pager.dart';
import 'package:txgc_app/model/person.dart';
import 'package:txgc_app/model/project_list.dart';
import 'package:txgc_app/services/index.dart';
import 'package:txgc_app/services/person.dart';
import 'package:txgc_app/services/request/base_resp.dart';
import 'package:txgc_app/utils/global.dart';

/// 项目部人员
class PersonProvider with ChangeNotifier {
  List<Person> listData = [];
  List<ProjectList> projectListData = [];

  int selectedIdx = -1; //当前选中的人员
  Pager pager =
      Pager.fromJson({'client_page': 1, 'every_page': 10, 'total_num': 10});

  /// 下拉赋值
  handleData(
    BaseResp _res,
  ) {
    var _data = _res.data;
    if (_data is List && _data.length != 0) {
      listData.addAll(
          _data.map<Person>((_item) => Person.fromJson(_item)).toList());
      pager = _res.pager;
      pager.clientPage++;
    }
    notifyListeners();
  }

  /// 分页
  ///
  /// [isReset] 默认分页加载后新加数据到列表后面，当设置 [isReset] 为true时
  /// 则清空之前数据列表
  Future getData(
      {int projectId, String name, String key, isReset: false}) async {
    Map<String, dynamic> payload = new Map<String, dynamic>.from({
      'project_id': projectId ?? Global.userCache.user.projectId,
      'name': name,
      'key': key,
      'clientPage': isReset ? 1 : pager.clientPage,
      'everyPage': pager.everyPage,
    });
    if (isReset) {
      listData = [];
    }

    notifyListeners();
    await handleData((await queryPerson(payload)));
  }

  /// 选中人员
  /// [index] 索引
  /// [isMultiple] 是否支持多选
  handleSelected(int index, {isMultiple = false}) {
    bool isCheck = listData[index].isCheck;
    selectedIdx = index;
    if (!isMultiple) {
      listData.forEach((item) {
        item.isCheck = false;
      });
    }
    listData[index].isCheck = !isCheck;
    notifyListeners();
  }

  /// 从项目部开始的所有层级部门列表，层级可选
  ///
  /// [level] 需要的层级0,1,2,3,4,不传返回所有5层,需要按照顺序传递+连续,3,4同级别
  /// [levelId] 当前层级的筛选id,level>0,eg: level:1,level_id=project_id,不传为所有
  Future getProjectData({
    int level,
    int levelId,
  }) async {
    Map<String, dynamic> payload = new Map<String, dynamic>.from({
      'level': '1,2,3,4',
      'level_id': Global.userCache.user.projectId,
    });

    BaseResp _res = await queryProjectList(payload);

    var _data = _res.data;
    if (_data is List && _data.length != 0) {
      projectListData = _data
          .map<ProjectList>((_item) => ProjectList.fromJson(_item))
          .toList();
    } else {
      projectListData = [];
    }

    notifyListeners();
  }
}
