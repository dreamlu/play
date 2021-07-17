import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:txgc_app/pages/app_page.dart';
import 'package:txgc_app/pages/approve/index.dart';
import 'package:txgc_app/pages/approve/view.dart';
import 'package:txgc_app/pages/canteen/carte.dart';
import 'package:txgc_app/pages/canteen/index.dart';
import 'package:txgc_app/pages/canteen/report.dart';
import 'package:txgc_app/pages/car/index.dart';
import 'package:txgc_app/pages/car/log.dart';
import 'package:txgc_app/pages/car/mana.dart';
import 'package:txgc_app/pages/contract/index.dart';
import 'package:txgc_app/pages/contract/preview.dart';
import 'package:txgc_app/pages/contract/view.dart';
import 'package:txgc_app/pages/doc/browse.dart';
import 'package:txgc_app/pages/doc/index.dart';
import 'package:txgc_app/pages/doc/view.dart';
import 'package:txgc_app/pages/dormer/index.dart';
import 'package:txgc_app/pages/dormer/mana.dart';
import 'package:txgc_app/pages/dormer/rule.dart';
import 'package:txgc_app/pages/dormer/view.dart';
import 'package:txgc_app/pages/driver/index.dart';
import 'package:txgc_app/pages/driver/mana.dart';
import 'package:txgc_app/pages/editor/index.dart';
import 'package:txgc_app/pages/editor/mana.dart';
import 'package:txgc_app/pages/editor/view.dart';
import 'package:txgc_app/pages/fuel/index.dart';
import 'package:txgc_app/pages/fuel/mana.dart';
import 'package:txgc_app/pages/handover/mana.dart';
import 'package:txgc_app/pages/handover/index.dart';
import 'package:txgc_app/pages/handover/project.dart';
import 'package:txgc_app/pages/handover/view.dart';
import 'package:txgc_app/pages/home/notification.dart';
import 'package:txgc_app/pages/home/todo.dart';
import 'package:txgc_app/pages/instance/index.dart';
import 'package:txgc_app/pages/instance/view.dart';
import 'package:txgc_app/pages/media/index.dart';
import 'package:txgc_app/pages/media/view.dart';
import 'package:txgc_app/pages/meeting/comfirm.dart';
import 'package:txgc_app/pages/meeting/index.dart';
import 'package:txgc_app/pages/meeting/mana.dart';
import 'package:txgc_app/pages/meeting/project.dart';
import 'package:txgc_app/pages/meeting/schedule.dart';
import 'package:txgc_app/pages/order/index.dart';
import 'package:txgc_app/pages/order/mana.dart';
import 'package:txgc_app/pages/order/receipt.dart';
import 'package:txgc_app/pages/order/view.dart';
import 'package:txgc_app/pages/question/index.dart';
import 'package:txgc_app/pages/question/mana.dart';
import 'package:txgc_app/pages/question/receipt.dart';
import 'package:txgc_app/pages/question/view.dart';
import 'package:txgc_app/pages/scan/index.dart';
import 'package:txgc_app/pages/sharing/index.dart';
import 'package:txgc_app/pages/sharing/view.dart';
import 'package:txgc_app/pages/signing/index.dart';
import 'package:txgc_app/pages/signing/view.dart';
import 'package:txgc_app/pages/site/index.dart';
import 'package:txgc_app/pages/travel/index.dart';
import 'package:txgc_app/pages/user/password.dart';
import 'package:txgc_app/pages/user/status.dart';
import 'package:txgc_app/pages/user/about.dart';
import 'package:txgc_app/pages/user/login.dart';
import 'package:txgc_app/pages/user/setting.dart';
import 'package:txgc_app/utils/index.dart';

Handler handoverHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return HanderOverPage();
});

Handler handoverViewHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return HanderOverViewPage(params2Json(params));
});

Handler handoverManaHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return HanderOverManaPage(params2Json(params));
});

Handler handoverProjectHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return HanderOverProjectPage(params2Json(params));
});

Handler signingHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SigningPage();
});

Handler signingViewHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SigningViewPage(params2Json(params));
});

Handler approveHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return ApprovePage();
});

Handler approveViewHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return ApproveViewPage(params2Json(params));
});

Handler dormerHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return DormerPage();
});

Handler dormerManaHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  // int id = int.parse(params["id"][0]);
  return DormerManaPage(params2Json(params));
});

Handler dormerRuleHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return DormerRulePage(params2Json(params));
});

Handler dormerViewHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return DormerViewPage(params2Json(params));
});

Handler orderHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return OrderPage();
});
Handler orderReceiptHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return OrderReceiptPage(params2Json(params));
});

Handler orderViewHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return OrderViewPage(params2Json(params));
});

Handler orderManaHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return OrderManaPage(params2Json(params));
});

Handler questionHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return QuestionPage();
});

Handler questionReceiptHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return QuestionReceiptPage(params2Json(params));
});

Handler questionViewHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return QuestionViewPage(params2Json(params));
});

Handler questionManaHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return QuestionManaPage(params2Json(params));
});

Handler travelHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return TravelPage();
});

Handler carHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return CarPage();
});

Handler carManaHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return CarManaPage(params2Json(params));
});

Handler carLogHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return CarLogPage(params2Json(params));
});

Handler driverHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return DriverPage();
});

Handler driverManaHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return DriverManaPage(params2Json(params));
});

Handler fuelHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return FuelPage();
});

Handler fuelManaHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return FuelManaPage(params2Json(params));
});

Handler docHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return DocPage();
});

Handler docViewHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return DocViewPage(params2Json(params));
});

Handler docBrowseHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return DocBrowsePage(params2Json(params));
});

Handler canteenHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return CanteenPage();
});

Handler canteenReportHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return CanteenReportPage(params2Json(params));
});

Handler canteenCarteHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return CanteenCartePage(params2Json(params));
});

Handler instanceHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return InstancePage();
});

Handler instanceViewHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return InstanceViewPage(params2Json(params));
});

Handler sharingHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SharingPage();
});

Handler sharingViewHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SharingViewPage(params2Json(params));
});

Handler mediaHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return MediaPage();
});

Handler mediaViewHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return MediaViewPage(params2Json(params));
});

Handler loginHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return UserLoginPage();
});

Handler aboutHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return UserAboutPage();
});

Handler userSettingHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return UserSettingPage();
});

Handler userStatusHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return UserStatusPage();
});

Handler userPasswordHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return UserPasswordPage();
});

Handler contractHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return ContractPage();
});

Handler contractViewHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return ContractViewPage(params2Json(params));
});

Handler contractPreviewHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return ContractPreviewPage(params2Json(params));
});

Handler editorHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return EditorPage();
});

Handler editorManaHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return EditorManaPage(params2Json(params));
});

Handler editorViewHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return EditorViewPage(params2Json(params));
});

Handler meetingHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return MeetingPage();
});

Handler meetingManaHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return MeetingManaPage(params2Json(params));
});

Handler meetingScheduleHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return MeetingSchedulePage(params2Json(params));
});

Handler meetingProjectHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return MeetingProjectPage(params2Json(params));
});

Handler meetingConfirmHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return MeetingComfirmPage(params2Json(params));
});

Handler todoHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return HomeTodoPage(params2Json(params));
});

Handler notificationHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return HomeNotificationPage(params2Json(params));
});

Handler scanHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return ScanPage(params2Json(params));
});

Handler siteHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SitePage();
});

Handler appHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return AppPage();
});
