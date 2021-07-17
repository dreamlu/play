import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_flutter/pdf_flutter.dart';
import 'package:txgc_app/components/form_item.dart';
import 'package:txgc_app/components/top_app_bar.dart';
import 'package:txgc_app/constants/index.dart';
import 'package:txgc_app/model/user_login.dart';
import 'package:txgc_app/services/index.dart';
import 'package:txgc_app/services/request/base_resp.dart';
import 'package:txgc_app/utils/dialog_media.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'global.dart';

/// 资源上传类型
class MediaModalType {
  final String label;
  final String icon;
  final Widget iconWidget;
  bool isShowBorder;
  MediaModalType(this.label, this.icon,
      {this.isShowBorder = false, this.iconWidget});
}

/// 年月日弹窗
/// [onConfirm] 点击右上角确认按钮回调
/// [onSelect] 选中列表中某一个item回调
/// [type] 日期格式
/// [yearBegin] 开始时间
/// [yearEnd] 结束时间
void showDatePickerModal(BuildContext context,
    {PickerConfirmCallback onConfirm,
    PickerSelectedCallback onSelect,
    type = PickerDateTimeType.kYMDHM,
    int yearBegin = 1900,
    int yearEnd = 2100}) {
  Picker(
          adapter: DateTimePickerAdapter(
            yearBegin: yearBegin,
            yearEnd: yearEnd,
            type: type,
            isNumberMonth: true,
            yearSuffix: "年",
            monthSuffix: "月",
            daySuffix: "日",
            minuteInterval: 5,
            minHour: 1,
            maxHour: 23,
          ),
          textAlign: TextAlign.right,
          selectedTextStyle: TextStyle(color: Theme.of(context).primaryColor),
          delimiter: [
            type == PickerDateTimeType.kYMD_AP_HM
                ? PickerDelimiter(
                    column: 5,
                    child: Container(
                      width: 16.0,
                      alignment: Alignment.center,
                      child: Text(':',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      color: Colors.white,
                    ))
                : PickerDelimiter(child: Container())
          ],
          onConfirm: onConfirm,
          onSelect: onSelect)
      .showModal(context);
}

/// 底部弹窗
/// [title] 弹窗标题
/// [desc] 弹窗描述
/// [isShowHeader] 是否显示弹窗的顶部header
/// [mediaTypeData] 列表 [List<MediaModalType>]
Future<String> openModalBottomSheet(BuildContext context,
    {String title,
    String desc,
    bool isShowHeader = false,
    List<MediaModalType> mediaTypeData = const []}) async {
  /// header
  Widget _header() {
    return Container(
      height: 148.h,
      width: 750.w,
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1.w, color: Color(0xFFD2D2D2)))),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 4.h),
              child: Text(
                title,
                style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            desc != null
                ? Text(desc,
                    style: TextStyle(color: Color(0xFF999999), fontSize: 24.sp))
                : Container()
          ]),
    );
  }

  /// 每个item
  Widget _item(BuildContext context, String icon, String label,
      {bool isShowBorder = false, Widget iconWidget}) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, label);
      },
      child: Container(
        height: 110.h,
        child: Row(
          children: [
            iconWidget ??
                Image.asset(icon, width: 34.w, height: 29.h, fit: BoxFit.cover),
            Container(
              width: 591.w,
              height: 110.h,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1.w,
                          color: Color(0xFFD2D2D2)
                              .withOpacity(isShowBorder ? 1 : 0)))),
              margin: EdgeInsets.only(left: 25.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: TextStyle(color: Color(0xFF000000), fontSize: 28.sp),
                  ),
                  Image.asset('images/right-tri.png')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  return await showModalBottomSheet(
      context: context,
      backgroundColor: Color(0),
      builder: (BuildContext context) {
        List<Widget> children = [];

        if (isShowHeader) {
          children.add(_header());
        }

        children.addAll(mediaTypeData
            .map((element) => _item(context, element.icon, element.label,
                isShowBorder: element.isShowBorder,
                iconWidget: element.iconWidget))
            .toList());

        return Container(
          height: ((115 *
                      (isShowHeader
                          ? (children.length - 1)
                          : children.length)) +
                  (isShowHeader ? 148 : 0))
              .h,
          width: 750.w,
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.w),
                topRight: Radius.circular(20.w),
              )),
          child: Column(
            children: children,
          ),
        );
      });
}

/// 手机相册
/// [context] BuildContext
/// [mediaType] 资源上传类型 可选 [camera,video ] 分为相册
/// 和视频上传
/// [title] 标题
/// [desc] 描述
/// [isShowHeader] 是否显示弹窗的顶部header
Future<MediaListType> showMediaModal(
  BuildContext context, {
  List mediaType = const ['camera'],
  bool isShowHeader = false,
  String title = '',
  String desc = '',
}) async {
  final List<MediaModalType> mediaTypeData = [];
  final mediaPicker = ImagePicker();
  bool isVideo = false;
  mediaType.forEach((item) {
    switch (item) {
      case 'camera':
        mediaTypeData.add(
            new MediaModalType('拍照', 'images/camera.png', isShowBorder: true));
        break;
      case 'video':
        isVideo = true;
        mediaTypeData.add(
            new MediaModalType('录视频', 'images/video.png', isShowBorder: true));
        break;
      default:
    }
  });

  mediaTypeData.add(new MediaModalType(
    '相册选择',
    'images/gallery.png',
  ));

  /// 截取视频第一帧
  Future<String> handleVideoThumbnail(String path) async {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: path,
      imageFormat: ImageFormat.JPEG,
      thumbnailPath: (await getTemporaryDirectory()).path,
      maxWidth: 220,
      quality: 50,
    );
    return thumbnailPath;
  }

  String type = await openModalBottomSheet(context,
      title: title,
      desc: desc,
      isShowHeader: isShowHeader,
      mediaTypeData: mediaTypeData);

  var pickedFile;
  String thumbnailPath;

  switch (type) {
    case '相册选择':
      pickedFile = isVideo
          ? await mediaPicker.getVideo(source: ImageSource.gallery)
          : await mediaPicker.getImage(source: ImageSource.gallery);
      break;
    case '拍照':
      pickedFile = await mediaPicker.getImage(source: ImageSource.camera);
      break;
    case '录视频':
      pickedFile = await mediaPicker.getVideo(source: ImageSource.camera);
      break;
    default:
  }

  if (pickedFile != null) {
    if (isVideo) {
      thumbnailPath = await handleVideoThumbnail(pickedFile.path);
    }

    return new MediaListType(
        type: 'file', src: pickedFile.path, thumbnailPath: thumbnailPath);
  }
  return new MediaListType();
}

/// 预览图片、视频、音频以及pdf
/// [url] 预览地址
/// [name] 新打开窗口顶部标题，仅限pdf游泳
void mediaPreviewer(BuildContext context, String url,
    {String name = '文件预览'}) async {
  String type = lookupMimeType(url);
  if (type != null) {
    if (type.startsWith('image/')) {
      dialogMedia(
        context,
        networkMedia: url,
      );
    } else if (type == 'application/pdf') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TopAppBar(
              PDF.network(
                url,
              ),
              name),
        ),
      );
    } else if (type.startsWith('video/')) {
      dialogMedia(context, networkMedia: url, isVideo: true);
    } else if (type.startsWith('audio/')) {
      dialogMedia(context, networkMedia: url, isAudio: true);
    }
  }
}

/// 解决路由参数value只有一个时，会被解析为数组结构问题
Map params2Json(Map list) {
  Map<String, dynamic> res = {};
  list.forEach((key, value) {
    var val = value;
    if (val.length == 1) {
      value = val[0];
    }
    res[key] = value;
  });
  return res;
}

/// 高德地图
Future<bool> gotoAMap(longitude, latitude, poiname,
    {bool isOpen = false}) async {
  var url =
      '${Platform.isAndroid ? 'android' : 'ios'}amap://navi?sourceApplication=amap&lat=$latitude&lon=$longitude&dev=0&poiname=${Uri.encodeFull(poiname)}';

  bool canLaunchUrl = await canLaunch(
    url,
  );

  if (!canLaunchUrl) {
    return false;
  }

  if (isOpen) {
    await launch(url);
  }

  return true;
}

/// 腾讯地图
Future<bool> gotoTencentMap(longitude, latitude, to,
    {bool isOpen = false}) async {
  var url =
      'qqmap://map/routeplan?fromcoord=CurrentLocation&type=drive&tocoord=$latitude,$longitude&referer=$T_MAP_KEY&to=${Uri.encodeFull(to)}';
  bool canLaunchUrl = await canLaunch(url);

  if (!canLaunchUrl) {
    return false;
  }

  if (isOpen) {
    await launch(url);
  }

  return canLaunchUrl;
}

/// 百度地图
Future<bool> gotoBaiduMap(longitude, latitude, {bool isOpen = false}) async {
  var url =
      'baidumap://map/direction?destination=$latitude,$longitude&coord_type=gcj02&mode=driving';

  bool canLaunchUrl = await canLaunch(url);

  if (!canLaunchUrl) {
    return false;
  }

  if (isOpen) {
    await launch(url);
  }

  return canLaunchUrl;
}

/// 苹果地图
Future<bool> gotoAppleMap(longitude, latitude, address,
    {bool isOpen = false}) async {
  var url =
      'http://maps.apple.com/?ll=$latitude,$longitude&q=${Uri.encodeFull(address)}';

  bool canLaunchUrl = await canLaunch(url);

  if (!canLaunchUrl) {
    return false;
  }

  if (isOpen) {
    await launch(url);
  }

  return true;
}

/// 谷歌地图
Future<bool> gotoGoogleMap(longitude, latitude, {bool isOpen = false}) async {
  var url =
      'comgooglemaps://?center=$latitude,$longitude&zoom=14&views=traffic';

  bool canLaunchUrl = await canLaunch(url);

  if (!canLaunchUrl) {
    return false;
  }

  if (isOpen) {
    await launch(url);
  }
  return true;
}

/// 网络图片缓存
Widget cacheImg(
  BuildContext context,
  String imageUrl, {
  double width,
  double height,
}) =>
    InkWell(
      onTap: () {
        dialogMedia(
          context,
          networkMedia: imageUrl,
        );
      },
      child: CachedNetworkImage(
        width: width,
        height: height,
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );

/// 获取token
void getToken({Function callback}) async {
  BaseResp res = await queryToken({'token': Global.userCache.user?.token});
  if (res.status == '200') {
    res.data['password'] = Global.userCache.password;
    Global.userCache = UserLogin.fromJson(res.data);
    print(
        'token更新成功:${Global.userCache.user.token},role:${Global.userCache.user.role.join(',')},data:${Global.userCache.user.toJson()}');
    Global.saveProfile(Global.userCache);
  } else {
    showToast('登录凭证失效，请重新登录');
    Global.userCache.id = null;
    Global.saveProfile(Global.userCache);
    if (callback != null) {
      callback();
    }
  }
}

/// 批量文件上传
Future<List> handleUploadMedia(List<MediaListType> fileList) async {
  var formData = FormData();

  /// [type]为网络图片则不需要上传
  List result = [];
  fileList.forEach((element) {
    if (element.type == 'network') {
      result.add({'rawUrl': element.src, 'name': element.name});
    }
  });

  /// 本地文件需要上传
  formData.files.addAll(fileList
      .where((element) => element.type == 'file')
      .map((element) => MapEntry(
          'file',
          MultipartFile.fromFileSync(element.src,
              filename: basename(element.src))))
      .toList());

  BaseResp res = await uploadFile(formData);
  if (res.data is List) {
    res.data.forEach((item) {
      result.add({'rawUrl': item['path'], 'name': basename(item['path'])});
    });
  }
  return result;
}

/// 毫秒转时分秒
String microseconds2Time(int microseconds) {
  int hours = microseconds ~/ (1000 * 60 * 60);
  int minutes = (microseconds - hours * 1000 * 60 * 60) ~/ 60000;
  int seconds = (microseconds - hours * 1000 * 60 * 60 - minutes * 60) ~/ 1000;

  return '${hours < 10 ? '0$hours' : hours}:${minutes < 10 ? '0$minutes' : minutes}:${seconds < 10 ? '0$seconds' : seconds}';
}
