import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  final String videoSrc; // 视频播放src
  final int mediaType; // 视频播放类型 0 为网络加载 1为本地资源
  Video(this.videoSrc, {this.mediaType = 0});

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initializePlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _videoPlay();
  }

  Future<void> initializePlayer() async {
    try {
      _videoPlayerController?.pause();

      if (widget.mediaType == 0) {
        _videoPlayerController = VideoPlayerController.network(widget.videoSrc);
      } else {
        _videoPlayerController =
            VideoPlayerController.file(File(widget.videoSrc));
      }

      await _videoPlayerController.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
      );

      setState(() {
        _chewieController = _chewieController;
      });
    } catch (e) {
      print(e);
    }
    return '';
  }

  Widget _videoPlay() {
    return _chewieController != null &&
            _chewieController.videoPlayerController.value.initialized
        ? Chewie(
            controller: _chewieController,
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xFFFF6035)),
                ),
                SizedBox(height: 20),
                Text('加载中...'),
              ],
            ),
          );
  }
}
