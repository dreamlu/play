import 'dart:io';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';
import 'package:fluro/fluro.dart';
import 'package:txgc_app/provides/approve.dart';
import 'package:txgc_app/provides/car.dart';
import 'package:txgc_app/provides/car_driver.dart';
import 'package:txgc_app/provides/car_log.dart';
import 'package:txgc_app/provides/car_record.dart';
import 'package:txgc_app/provides/engine.dart';
import 'package:txgc_app/provides/file_receive.dart';
import 'package:txgc_app/provides/meeting.dart';
import 'package:txgc_app/provides/order.dart';
import 'package:txgc_app/provides/person.dart';
import 'package:txgc_app/provides/share_edit.dart';
import 'package:txgc_app/provides/signature.dart';
import 'package:txgc_app/provides/site.dart';
import 'package:txgc_app/provides/task.dart';
import 'package:txgc_app/provides/user.dart';
import 'package:txgc_app/utils/global.dart';
import './provides/menu.dart';
import './routers/application.dart';
import './routers/routers.dart';
import './pages/app_page.dart';
import 'constants/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 禁止程序横屏显示
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  if (Platform.isAndroid) {
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  // 高德地图定位秘钥
  AMapFlutterLocation.setApiKey(
    A_MAP_ANDROID,
    A_MAP_IOS,
  );

  Global.init().then((value) => runApp((MultiProvider(
        // provider初始化
        providers: [
          ChangeNotifierProvider(create: (_) => MenuProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => PersonProvider()),
          ChangeNotifierProvider(create: (_) => TaskProvider()),
          ChangeNotifierProvider(create: (_) => FileReceiveProvider()),
          ChangeNotifierProvider(create: (_) => SignatureProvider()),
          ChangeNotifierProvider(create: (_) => ApproveProvider()),
          ChangeNotifierProvider(create: (_) => OrderProvider()),
          ChangeNotifierProvider(create: (_) => CarProvider()),
          ChangeNotifierProvider(create: (_) => CarLogProvider()),
          ChangeNotifierProvider(create: (_) => ShareEditProvider()),
          ChangeNotifierProvider(create: (_) => EngineProvider()),
          ChangeNotifierProvider(create: (_) => CarDriverProvider()),
          ChangeNotifierProvider(create: (_) => CarRecordProvider()),
          ChangeNotifierProvider(create: (_) => MeetingProvider()),
          ChangeNotifierProvider(create: (_) => SiteProvider()),
        ],
        child: MyApp(),
      ))));
}

class MyApp extends StatelessWidget {
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();

  @override
  Widget build(BuildContext context) {
    final router = FluroRouter();
    Routers.configureRouters(router);
    Application.router = router;

    return Container(
        child: ScreenUtilInit(
      designSize: Size(750, 1334),
      allowFontScaling: false,
      builder: () => OKToast(
        child: MaterialApp(
          navigatorObservers: [MyApp.routeObserver],
          title: '通信工程',
          localizationsDelegates: [
            PickerLocalizationsDelegate.delegate,
            // 如果要使用本地化，请添加此行，则可以显示中文按钮
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('zh', 'CH'),
          ],
          onGenerateRoute: Application.router.generator,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color(0xFF009CFF),
          ),
          home: AppPage(),
        ),
      ),
    ));
  }
}
