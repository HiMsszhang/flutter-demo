import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:chewie/chewie.dart';
import 'package:molan_edu/widgets/custom_controls.dart';
import 'package:video_player/video_player.dart';

class FullscreenVideoPage extends StatefulWidget {
  final String url;
  final String title;
  final VoidCallback onFinished;
  const FullscreenVideoPage({
    Key key,
    this.url,
    this.title = '',
    this.onFinished,
  }) : super(key: key);

  @override
  _FullscreenVideoPageState createState() => _FullscreenVideoPageState();
}

class _FullscreenVideoPageState extends State<FullscreenVideoPage> with UtilsMixin {
  VideoPlayerController _controller;
  ChewieController _chewieController;
  Future<void> _future;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    _controller = VideoPlayerController.network(widget.url);
    if (_controller.value.hasError) {
      print(_controller.value.errorDescription);
    }
    _future = initVideoPlayer();
    _controller.addListener(_videoListener);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    _chewieController.dispose();
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  Future<void> initVideoPlayer() async {
    await _controller.initialize();
    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: _controller,
        autoPlay: true,
        looping: false,
        autoInitialize: true,
        aspectRatio: _controller.value.aspectRatio ?? (16 / 9),
        allowFullScreen: false,
        allowedScreenSleep: false,
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        customControls: CustomControls(
          title: widget.title,
          showTopBar: true,
          onBack: () async {
            await _back();
          },
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            ),
          );
        },
        placeholder: Container(color: Colors.black),
      );
    });
  }

  _videoListener() async {
    var value = _controller.value.position.inSeconds;
    var duration = _controller.value.duration.inSeconds;
    if (value >= duration) {
      if (widget.onFinished != null) widget.onFinished();
      await _back();
    }
  }

  _back() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    NavigatorUtils.pop(context);
  }

  Future<bool> _onPop() async {
    await _back();
    return new Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPop,
      child: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Chewie(controller: _chewieController);
          } else {
            return MyLoading();
          }
        },
      ),
    );
  }
}
