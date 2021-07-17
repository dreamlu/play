import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerMedia extends StatefulWidget {
  final String url;
  final String name;
  final PlayerMode mode;
  AudioPlayerMedia(this.url, {this.mode = PlayerMode.MEDIA_PLAYER, this.name});
  @override
  _AudioPlayerMediaState createState() => _AudioPlayerMediaState();
}

class _AudioPlayerMediaState extends State<AudioPlayerMedia> {
  AudioPlayer _audioPlayer;
  Duration _duration;
  Duration _position;
  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;

  get _durationText => _duration?.toString()?.split('.')?.first ?? '';
  get _positionText => _position?.toString()?.split('.')?.first ?? '';

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  @override
  void dispose() {
    //释放
    _audioPlayer.dispose();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  _initAudioPlayer() {
    //初始化
    _audioPlayer = AudioPlayer(mode: widget.mode);

    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);

      if (Theme.of(context).platform == TargetPlatform.iOS) {
        _audioPlayer.startHeadlessService();

        _audioPlayer.setNotification(
          title: widget.name,
          duration: duration,
        );
      }
    });

    //监听进度
    _positionSubscription =
        _audioPlayer.onAudioPositionChanged.listen((p) => setState(() {
              _position = p;
            }));

    //播放完成
    _playerCompleteSubscription =
        _audioPlayer.onPlayerCompletion.listen((event) {
      //_onComplete();
      setState(() {
        _position = Duration();
      });
    });

    //监听报错
    _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        //_playerState = PlayerState.stopped;
        _duration = Duration(seconds: 0);
        _position = Duration(seconds: 0);
      });
    });

    //播放状态改变
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {});
    });

    ///// iOS中来自通知区域的玩家状态变化流。
    _audioPlayer.onNotificationPlayerStateChanged.listen((state) {
      if (!mounted) return;
    });
  }

  //开始播放
  void _play() async {
    final playPosition = (_position != null &&
            _duration != null &&
            _position.inMilliseconds > 0 &&
            _position.inMilliseconds < _duration.inMilliseconds)
        ? _position
        : null;
    await _audioPlayer.play(widget.url, position: playPosition);
  }

  //暂停
  void _pause() async {
    await _audioPlayer.pause();
  }

  //停止播放
  _stop() async {
    final result = await _audioPlayer.stop();
    if (result == 1) {
      setState(() {
        _position = Duration();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _position != null
              ? '${_positionText ?? ''} / ${_durationText ?? ''}'
              : _duration != null
                  ? _durationText
                  : '',
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Slider(
            activeColor: Color(0xFF009CFF),
            onChanged: (v) {
              final position = v * _duration.inMilliseconds;
              _audioPlayer.seek(Duration(milliseconds: position.round()));
            },
            value: (_position != null &&
                    _duration != null &&
                    _position.inMilliseconds > 0 &&
                    _position.inMilliseconds < _duration.inMilliseconds)
                ? _position.inMilliseconds / _duration.inMilliseconds
                : 0.0,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  color: Color(0xFF009CFF),
                ),
                onPressed: () {
                  _play();
                }),
            IconButton(
                icon: Icon(
                  Icons.pause,
                  color: Color(0xFF009CFF),
                ),
                onPressed: () {
                  _pause();
                }),
            IconButton(
                icon: Icon(
                  Icons.stop,
                  color: Color(0xFF009CFF),
                ),
                onPressed: () {
                  _stop();
                }),
          ],
        )
      ],
    ));
  }
}
