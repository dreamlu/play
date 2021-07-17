import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:launch_review/launch_review.dart';
import 'package:txgc_app/model/site.dart';
import 'package:txgc_app/utils/confirm_dialog.dart';
import 'package:txgc_app/utils/index.dart';
import 'package:txgc_app/utils/location.dart';

class CardItem extends StatelessWidget {
  final Site item;

  CardItem(
    this.item,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20.h),
        width: 700.w,
        padding:
            EdgeInsets.only(left: 30.w, right: 42.w, bottom: 25.h, top: 25.h),
        decoration: BoxDecoration(
            color: Color(0xFFF5F6FA),
            borderRadius: BorderRadius.circular(10.w)),
        child: _taskBody(context));
  }

  Widget _taskBody(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _title(),
        _nav(context),
      ],
    );
  }

  Widget _title() {
    return Expanded(
      child: Container(
        child: Text(
          item.name,
          style: TextStyle(
            fontSize: 32.sp,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _nav(BuildContext context) {
    return Container(
        child: InkWell(
      onTap: () {
        handleMapApp(context);
      },
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10.w),
            child: Image.asset('images/loc.png'),
          ),
          Text(
            '导航',
            style: TextStyle(color: Color(0xFF009CFF), fontSize: 26.sp),
          )
        ],
      ),
    ));
  }

  void handleMapApp(BuildContext context) async {
    Location res = new Location(latitude: double.parse(item.lat.toString()), longitude: double.parse(item.lng.toString()));

    final List<MediaModalType> mediaTypeData = [];
    if (await gotoAMap(res.longitude, res.latitude, '浙江省江干区浙江传媒学院')) {
      mediaTypeData.add(
          new MediaModalType('高德地图', 'images/amap.png', isShowBorder: true));
    }
    if (await gotoTencentMap(res.longitude, res.latitude, '浙江省江干区浙江传媒学院')) {
      mediaTypeData.add(new MediaModalType('腾讯地图', 'images/tencent-map.png',
          isShowBorder: true));
    }
    if (await gotoBaiduMap(
      res.longitude,
      res.latitude,
    )) {
      mediaTypeData.add(new MediaModalType('百度地图', 'images/baidu-map.png',
          isShowBorder: true));
    }
    if (await gotoGoogleMap(res.longitude, res.latitude)) {
      mediaTypeData.add(new MediaModalType('谷歌地图', 'images/google-map.png',
          isShowBorder: true));
    }

    if (Platform.isIOS) {
      mediaTypeData.add(
        new MediaModalType('苹果地图', 'images/apple-map.png', isShowBorder: true),
      );
    }

    if (mediaTypeData.length == 0) {
      if (await confirmDialog(context,
          desc: '系统检测您暂未安装任何导航App，是否前往应用市场下载导航软件', okText: '确认')) {
        LaunchReview.launch(
            writeReview: false,
            androidAppId: "com.autonavi.minimap",
            iOSAppId: "id461703208");
      }
      return;
    }

    mediaTypeData.add(
      new MediaModalType('取消导航', '',
          iconWidget: Icon(
            Icons.close_rounded,
            size: 34.w,
          )),
    );

    // mediaTypeData[mediaTypeData.length - 1].isShowBorder = false;

    String type = await openModalBottomSheet(
      context,
      mediaTypeData: mediaTypeData,
    );

    switch (type) {
      case '高德地图':
        gotoAMap(res.longitude, res.latitude, '浙江省江干区浙江传媒学院', isOpen: true);
        break;
      case '腾讯地图':
        gotoTencentMap(res.longitude, res.latitude, '浙江省江干区浙江传媒学院',
            isOpen: true);
        break;
      case '百度地图':
        gotoBaiduMap(res.longitude, res.latitude, isOpen: true);
        break;
      case '苹果地图':
        gotoAppleMap(res.longitude, res.latitude, '浙江省江干区浙江传媒学院', isOpen: true);
        break;
      case '谷歌地图':
        gotoGoogleMap(res.longitude, res.latitude, isOpen: true);
        break;
      default:
    }
  }
}
