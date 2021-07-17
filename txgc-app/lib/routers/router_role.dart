import 'package:flutter/material.dart';
import 'package:txgc_app/utils/global.dart';

// 定义角色策略
// role:
// -1: admin直接返回不验证,所有权限
// 0: 项目部总调度: 所有权限除了admin相关
// 1: 项目部领导: 和0一样,但是只能看不能操作
// 2: 工程领导: 只能查看大屏和修改自己的状态
// 3: 项目部人员: 任务交接,文件签认,文件审批,
// 影像资料上传+查看,pdf签字,共享资源查看,文件接收,
// 共享编辑,施工安全质量典型案例查看,合同查看,
// 人员选择列表,物资申请
// 系统通知,(包含工程id的)大屏展示,会议管理
// 4: (工程下)施工部人员: 资料自动填写
// 缺少的15
// 5: 影像资料管理员: 影像资料管理(文件夹创建,文件删除等…)
// 6: 天窗负责人: 天窗管理
// 7: 资源共享管理员: 资源共享管理(文件夹创建,文件删除等…)
// 8: 施工安全工程师: 施工安全质量典型案例
// 9: 合同管理员: 合同管理
// 10: 食堂管理员: 食堂考勤管理
// 11: (施工部—部门—工程部—项目调度)工程调度: 食堂考勤管理,施工进度管理,天窗管理,分部管理,分部站点管理
// 12: 司机车辆管理员：司机车辆管理
// 13: 司机：维修加油上报
// 14: 考勤管理员：考勤管理
// 15: 分部负责人: 分部管理,站点管理
// 16: 大屏管理员: 大屏管理
// 17: 物资管理员: 物资管理

class RoleType {
  bool canMana; //是否拥有管理权限
  bool canView; //是否拥有查看权限
  final List<String> manaRoles = ['-1']; // 管理权限列表
  final List<String> viewRoles = ['-1']; // 查看权限列表

  RoleType({
    this.canMana,
    this.canView,
    List<String> manaRoles = const [],
    List<String> viewRoles = const [],
  }) {
    this.manaRoles.addAll(manaRoles);
    this.viewRoles.addAll(viewRoles);
  }
}

/// 使用
/// 在需要权限的地方调用 RouterRole.getRole(context).canMana
/// 其中的canMana便是可编辑操作
/// canView表示可查看权限
class RouterRole {
  static Map<String, RoleType> roleMap = {
    /// 任务交接
    '/handover': new RoleType(manaRoles: ['0', '3'], viewRoles: ['1', '2']),
    '/handover/view':
        new RoleType(manaRoles: ['0', '3'], viewRoles: ['1', '2']),
    '/handover/mana': new RoleType(manaRoles: ['0', '3']),
    '/handover/project': new RoleType(
      manaRoles: ['0', '3'],
    ),

    /// 文件签认
    '/signing': new RoleType(),
    '/signing/view': new RoleType(),

    /// 影像资料收集
    '/media': new RoleType(manaRoles: ['0', '3', '7'], viewRoles: ['1', '2']),
    '/media/view':
        new RoleType(manaRoles: ['0', '3', '7'], viewRoles: ['1', '2']),
  };

  /// 返回页面权限
  /// [canMana] 是否拥有管理权限
  /// [canView] 是否拥有查看权限
  static RoleType getRole(BuildContext context) {
    /// 当前页面路径 去除query参数
    String path = ModalRoute.of(context).settings.name.split('?')[0];

    /// 用户所拥有权限
    List<String> roles = Global.userCache.user.role;

    /// 当前页面所属管理权限列表
    List<String> pageRoles = roleMap[path].manaRoles;

    /// 当前页面所属查看权限列表
    List<String> pageViewRoles = roleMap[path].viewRoles;

    /// 一旦拥有管理权限，则直接返回
    for (var i = 0; i < pageRoles.length; i++) {
      if (roles.indexOf(pageRoles[i]) != -1) {
        return new RoleType(canMana: true, canView: true);
      }
    }

    for (var i = 0; i < pageViewRoles.length; i++) {
      /// 一旦拥有查看权限，则直接返回
      if (roles.indexOf(pageViewRoles[i]) != -1) {
        return new RoleType(canMana: false, canView: true);
      }
    }

    return new RoleType(canMana: false, canView: false);
  }

  /// 返回当前用户所在权限是否在管理权限之中
  static bool isCanMana(List<String> checkRoles) {
    /// 用户所拥有权限
    List<String> roles = Global.userCache.user.role;

    /// 一旦拥有管理权限，则直接返回
    for (var i = 0; i < checkRoles.length; i++) {
      if (roles.indexOf(checkRoles[i]) != -1) {
        return true;
      }
    }
    return false;
  }
}

// /// 文件签认
// router.define('/signing', handler: signingHandler);
// router.define('/signing/view', handler: signingViewHandler);

// /// 文件审批
// router.define('/approve', handler: approveHandler);
// router.define('/approve/view', handler: approveViewHandler);

// /// 天窗施工管理
// router.define('/dormer', handler: dormerHandler);
// router.define('/dormer/mana', handler: dormerManaHandler);
// router.define('/dormer/rule', handler: dormerRuleHandler);
// router.define('/dormer/view', handler: dormerViewHandler);

// /// 派工单
// router.define('/order', handler: orderHandler);
// router.define('/order/receipt', handler: orderReceiptHandler);
// router.define('/order/view', handler: orderViewHandler);
// router.define('/order/mana', handler: orderManaHandler);

// /// 问题库克缺
// router.define('/question', handler: questionHandler);
// router.define('/question/receipt', handler: questionReceiptHandler);
// router.define('/question/view', handler: questionViewHandler);
// router.define('/question/mana', handler: questionManaHandler);

// /// 车辆、司机管理
// router.define('/travel', handler: travelHandler);

// /// 车辆管理
// router.define('/car', handler: carHandler);
// router.define('/car/mana', handler: carManaHandler);
// router.define('/car/log', handler: carLogHandler);

// /// 司机管理
// router.define('/driver', handler: driverHandler);
// router.define('/driver/mana', handler: driverManaHandler);

// /// 维修、加油上报
// router.define('/fuel', handler: fuelHandler);
// router.define('/fuel/mana', handler: fuelManaHandler);

// /// 文件接收状态确认
// router.define('/doc', handler: docHandler);
// router.define('/doc/view', handler: docViewHandler);
// router.define('/doc/browse', handler: docBrowseHandler);

// /// 食堂考勤
// router.define('/canteen', handler: canteenHandler);
// router.define('/canteen/report', handler: canteenReportHandler);
// router.define('/canteen/carte', handler: canteenCarteHandler);

// /// 施工安全质量典型案例库
// router.define('/instance', handler: instanceHandler);
// router.define('/instance/view', handler: instanceViewHandler);

// /// 施工安全质量典型案例库
// router.define('/instance', handler: instanceHandler);
// router.define('/instance/view', handler: instanceViewHandler);

// /// 资源共享
// router.define('/sharing', handler: sharingHandler);
// router.define('/sharing/view', handler: sharingViewHandler);

// /// 资源共享
// router.define('/media', handler: mediaHandler);
// router.define('/media/view', handler: mediaViewHandler);

// /// 个人中心
// router.define('/login', handler: loginHandler);
// router.define('/about', handler: aboutHandler);
// router.define('/user/setting', handler: userSettingHandler);
// router.define('/user/status', handler: userStatusHandler);
// router.define('/user/password', handler: userPasswordHandler);

// /// 合同管理
// router.define('/contract', handler: contractHandler);
// router.define('/contract/view', handler: contractViewHandler);
// router.define('/contract/preview', handler: contractPreviewHandler);

// /// 共享编辑
// router.define('/editor', handler: editorHandler);
// router.define('/editor/mana', handler: editorManaHandler);
// router.define('/editor/view', handler: editorViewHandler);

// /// 会议管理
// router.define('/meeting', handler: meetingHandler);
// router.define('/meeting/mana', handler: meetingManaHandler);
// router.define('/meeting/schedule', handler: meetingScheduleHandler);
// router.define('/meeting/project', handler: meetingProjectHandler);
// router.define('/meeting/confirm', handler: meetingConfirmHandler);

// /// 首页待办事项
// router.define('/todo', handler: todoHandler);

// /// 首页通知
// router.define('/notification', handler: notificationHandler);

// /// 扫码
// router.define('/scan', handler: scanHandler);

// /// 扫码
// router.define('/site', handler: siteHandler);

// /// 首页
// router.define('/app', handler: appHandler);
