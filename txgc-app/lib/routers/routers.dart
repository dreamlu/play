import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import './router_handle.dart';

class Routers {
  static void configureRouters(FluroRouter router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return TopAppBar(
          Center(
              child: Center(
            child: Text('该功能正在开发中'),
          )),
          '404页面');
    });

    /// 任务交接
    router.define('/handover', handler: handoverHandler);
    router.define('/handover/view', handler: handoverViewHandler);
    router.define('/handover/mana', handler: handoverManaHandler);
    router.define('/handover/project', handler: handoverProjectHandler);

    /// 文件签认
    router.define('/signing', handler: signingHandler);
    router.define('/signing/view', handler: signingViewHandler);

    /// 文件审批
    router.define('/approve', handler: approveHandler);
    router.define('/approve/view', handler: approveViewHandler);

    /// 天窗施工管理
    router.define('/dormer', handler: dormerHandler);
    router.define('/dormer/mana', handler: dormerManaHandler);
    router.define('/dormer/rule', handler: dormerRuleHandler);
    router.define('/dormer/view', handler: dormerViewHandler);

    /// 派工单
    router.define('/order', handler: orderHandler);
    router.define('/order/receipt', handler: orderReceiptHandler);
    router.define('/order/view', handler: orderViewHandler);
    router.define('/order/mana', handler: orderManaHandler);

    /// 问题库克缺
    router.define('/question', handler: questionHandler);
    router.define('/question/receipt', handler: questionReceiptHandler);
    router.define('/question/view', handler: questionViewHandler);
    router.define('/question/mana', handler: questionManaHandler);

    /// 车辆、司机管理
    router.define('/travel', handler: travelHandler);

    /// 车辆管理
    router.define('/car', handler: carHandler);
    router.define('/car/mana', handler: carManaHandler);
    router.define('/car/log', handler: carLogHandler);

    /// 司机管理
    router.define('/driver', handler: driverHandler);
    router.define('/driver/mana', handler: driverManaHandler);

    /// 维修、加油上报
    router.define('/fuel', handler: fuelHandler);
    router.define('/fuel/mana', handler: fuelManaHandler);

    /// 文件接收状态确认
    router.define('/doc', handler: docHandler);
    router.define('/doc/view', handler: docViewHandler);
    router.define('/doc/browse', handler: docBrowseHandler);

    /// 食堂考勤
    router.define('/canteen', handler: canteenHandler);
    router.define('/canteen/report', handler: canteenReportHandler);
    router.define('/canteen/carte', handler: canteenCarteHandler);

    /// 施工安全质量典型案例库
    router.define('/instance', handler: instanceHandler);
    router.define('/instance/view', handler: instanceViewHandler);

    /// 施工安全质量典型案例库
    router.define('/instance', handler: instanceHandler);
    router.define('/instance/view', handler: instanceViewHandler);

    /// 资源共享
    router.define('/sharing', handler: sharingHandler);
    router.define('/sharing/view', handler: sharingViewHandler);

    /// 资源共享
    router.define('/media', handler: mediaHandler);
    router.define('/media/view', handler: mediaViewHandler);

    /// 个人中心
    router.define('/login', handler: loginHandler);
    router.define('/about', handler: aboutHandler);
    router.define('/user/setting', handler: userSettingHandler);
    router.define('/user/status', handler: userStatusHandler);
    router.define('/user/password', handler: userPasswordHandler);

    /// 合同管理
    router.define('/contract', handler: contractHandler);
    router.define('/contract/view', handler: contractViewHandler);
    router.define('/contract/preview', handler: contractPreviewHandler);

    /// 共享编辑
    router.define('/editor', handler: editorHandler);
    router.define('/editor/mana', handler: editorManaHandler);
    router.define('/editor/view', handler: editorViewHandler);

    /// 会议管理
    router.define('/meeting', handler: meetingHandler);
    router.define('/meeting/mana', handler: meetingManaHandler);
    router.define('/meeting/schedule', handler: meetingScheduleHandler);
    router.define('/meeting/project', handler: meetingProjectHandler);
    router.define('/meeting/confirm', handler: meetingConfirmHandler);

    /// 首页待办事项
    router.define('/todo', handler: todoHandler);

    /// 首页通知
    router.define('/notification', handler: notificationHandler);

    /// 扫码
    router.define('/scan', handler: scanHandler);

    /// 扫码
    router.define('/site', handler: siteHandler);

    /// 首页
    router.define('/app', handler: appHandler);
  }
}
