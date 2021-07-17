import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:txgc_app/model/client.dart';
import 'package:txgc_app/model/user_login.dart';
import 'package:txgc_app/routers/application.dart';
import 'package:txgc_app/services/index.dart';
import 'package:txgc_app/services/request/base_resp.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/index.dart';

/// 用户个人信息
class UserProvider with ChangeNotifier {
  Client clientDetail = Client.fromJson({'type': 2});

  /// 用户个人信息请求
  Future getData(BuildContext context, {id: 0, phone, isReset: false}) async {
    // Map<String, dynamic> payload = new Map<String, dynamic>.from(
    //     {'id': id, 'admin_id': 52, 'phone': phone});
    // if (id != 0) {
    //   // 指定id
    //   payload['id'] = id;
    // } else if (Global.userCache['id'] != null) {
    //   // 本地缓存查找
    //   payload['id'] = Global.userCache['id'];
    // }
    // handleData((await infoClient(payload)));
    getAuthentication(context);
  }

  /// 赋值
  ///
  /// [isReset] 清空本地信息，当设置 [isReset] 为true时
  void handleData(BaseResp _res, {isReset: false}) {
    if (_res.status == '200') {
      clientDetail = Client.fromJson(_res.data);
    }
    if (isReset) {
      clientDetail = Client.fromJson({'type': 2});
    }
    notifyListeners();
  }

  /// 登录
  Future<bool> handleLogin() async {
    BaseResp res;
    res = await userLogin({
      'account': Global.formRecord['account'],
      'password': Global.formRecord['password'],
    });
    if (res.status == '200') {
      res.data['password'] = Global.formRecord['password'];
      Global.userCache = UserLogin.fromJson(res.data);
      Global.userCache.user.token = Global.userCache.token;
      Global.saveProfile(Global.userCache);
      return true;
    }
    showToast('账号或密码错误');
    return false;
  }

  /// 鉴别用户是否凭证失效
  void getAuthentication(BuildContext context) {
    getToken(callback: () {
      Application.router.navigateTo(context, '/login',
          clearStack: true, transition: TransitionType.native);
    });
  }

  /// 修改个人资料
  Future<bool> handleUpdate() async {
    // BaseResp res;
    // res = await checkSms({
    //   'phone': Global.formRecord['phone'],
    //   'code': Global.formRecord['code'],
    // });
    // if (res.status == '200') {
    //   res = await updateClient({
    //     'id': clientDetail.id,
    //     'phone': Global.formRecord['phone'],
    //     'name': Global.formRecord['name'],
    //   });
    //   if (res.status == '206') {
    //     showToast('修改成功');
    //     return true;
    //   }
    //   showToast(res.msg);
    //   return false;
    // }
    // showToast('验证码错误');
    return false;
  }

  /// 发通知
  // "typ": "0消息通知,1待办",
  // "is_do": "是否做/读,0否,1是",
  // "kind": "// typ:0 \t// 0天窗,1工单回执,2问题克缺,3影像资料删除 \t// typ:1 \t// 0任务交接,1文件签认,2文件审批,3天窗,4派工单,5问题库克缺,6会议管理,7文件接收状态确认,8共享编辑",
  // "nid": "通知id,对应类型的数据id",
  // "from": "来自谁,记录",
  // "to_id": "发给谁id,project_person_id",
  // "desc": "额外描述"

  Future<bool> handleNotify() async {
    BaseResp res = await createNotify({
      'typ': Global.formRecord['typ'],
      'is_do': Global.formRecord['is_do'],
      'kind': Global.formRecord['kind'],
      'nid': Global.formRecord['nid'],
      'from': Global.userCache.user.id.toString(),
      'to_id': Global.formRecord['to_id'],
      'desc': Global.formRecord['desc'],
    });
    if (res.status == '200') {
      showToast('操作成功');
      return true;
    }
    return false;
  }
}
