import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:txgc_app/components/audio_player_media.dart';
import 'package:txgc_app/components/video.dart';

/// 弹窗预览视频、图片以及音频
/// [networkMedia] 网络地址url
/// [fileMedia] 本地文件地址url
/// [isVideo] 是否为视频预览
/// [isAudio] 是否为音频预览
void dialogMedia(BuildContext context,
        {String networkMedia,
        String fileMedia,
        bool isVideo = false,
        isAudio = false}) =>
    showDialog(
      context: context,
      builder: (context) {
        var child;
        if (networkMedia != null) {
          if (isVideo) {
            child = Video(networkMedia);
          } else if (isAudio) {
            child = AudioPlayerMedia(networkMedia);
          } else {
            child = NetworkImage(networkMedia);
          }
        } else if (fileMedia != null) {
          if (isVideo) {
            child = Video(fileMedia, mediaType: 1);
          } else {
            child = FileImage(File(fileMedia));
          }
        }
        return Dialog(
          child: isAudio
              ? Container(
                  alignment: Alignment.center,
                  height: 400.h,
                  child: child,
                )
              : isVideo
                  ? Container(
                      color: Colors.black,
                      height: 400.h,
                      child: child,
                    )
                  : Container(
                      child: PhotoView(
                        tightMode: true,
                        imageProvider: child,
                      ),
                    ),
        );
      },
    );
