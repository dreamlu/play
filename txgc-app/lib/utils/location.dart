import 'dart:async';
import 'dart:io';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';

/// 本地授权
class Location {
  final double latitude;
  final double longitude;
  final String desc;
  Location({
    this.longitude,
    this.latitude,
    this.desc = '',
  });
}

Future<Location> getLocation({bool isAddress = true}) async {
  Map<String, Object> _locationResult;

  AMapFlutterLocation _locationPlugin = new AMapFlutterLocation();

  // StreamSubscription<Map<String, Object>> _locationListener;

  ///iOS 获取native精度类型
  if (Platform.isIOS) {
    AMapAccuracyAuthorization currentAccuracyAuthorization =
        await _locationPlugin.getSystemAccuracyAuthorization();
    if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy) {
      print("精确定位类型");
    } else if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationReducedAccuracy) {
      print("模糊定位类型");
    } else {
      print("未知定位类型");
    }
  }

  ///设置定位参数
  if (null != _locationPlugin) {
    AMapLocationOption locationOption = new AMapLocationOption();

    ///是否单次定位
    locationOption.onceLocation = false;

    ///是否需要返回逆地理信息
    locationOption.needAddress = true;

    ///逆地理信息的语言类型
    locationOption.geoLanguage = GeoLanguage.DEFAULT;

    locationOption.desiredLocationAccuracyAuthorizationMode =
        AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

    locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

    ///设置Android端连续定位的定位间隔
    locationOption.locationInterval = 2000;

    ///设置Android端的定位模式<br>
    ///可选值：<br>
    ///<li>[AMapLocationMode.Battery_Saving]</li>
    ///<li>[AMapLocationMode.Device_Sensors]</li>
    ///<li>[AMapLocationMode.Hight_Accuracy]</li>
    locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

    ///设置iOS端的定位最小更新距离<br>
    locationOption.distanceFilter = -1;

    ///设置iOS端期望的定位精度
    /// 可选值：<br>
    /// <li>[DesiredAccuracy.Best] 最高精度</li>
    /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
    /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
    /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
    /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
    locationOption.desiredAccuracy = DesiredAccuracy.Best;

    ///设置iOS端是否允许系统暂停定位
    locationOption.pausesLocationUpdatesAutomatically = false;

    ///将定位参数设置给定位插件
    _locationPlugin.setLocationOption(locationOption);
  }

  _locationPlugin.startLocation();

  Future<void> init() async {
    var isCompeted = false;
    await Future.doWhile(() {
      if (isCompeted) {
        print(_locationResult);
        return false;
      }

      // _locationListener =
      _locationPlugin
          .onLocationChanged()
          .asBroadcastStream()
          .listen((Map<String, Object> result) {
        _locationResult = result;
        isCompeted = true;
      });
      // _locationListener.broadcast();
      return new Future.delayed(new Duration(seconds: 1), () {
        return true;
      });
    }).catchError(print);
  }

  await init();

  ///移除定位监听
  // if (null != _locationListener) {
  //   _locationListener.cancel();
  // }

  //销毁定位
  // _locationPlugin.destroy();

  if (_locationResult != null) {
    return new Location(
      desc: _locationResult['address'],
      latitude: _locationResult['latitude'] is double
          ? _locationResult['latitude']
          : double.parse(_locationResult['latitude']),
      longitude: _locationResult['longitude'] is double
          ? _locationResult['longitude']
          : double.parse(_locationResult['longitude']),
    );
  } else {
    print('获取定位信息失败');
    return new Location();
  }
}
