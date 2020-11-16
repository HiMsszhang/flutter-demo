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
  const FullscreenVideoPage({
    Key key,
    this.url,
    this.title = '',
  }) : super(key: key);

  @override
  _FullscreenVideoPageState createState() => _FullscreenVideoPageState();
}

class _FullscreenVideoPageState extends State<FullscreenVideoPage> with UtilsMixin {
  VideoPlayerController _controller;
  ChewieController _chewieController;

  @override
  void initState() {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);
    _controller = VideoPlayerController.network(widget.url);
    if (_controller.value.hasError) {
      print(_controller.value.errorDescription);
    }
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: false,
      autoInitialize: true,
      aspectRatio: 16 / 9,
      fullScreenByDefault: true,
      allowFullScreen: true,
      allowedScreenSleep: false,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      customControls: CustomControls(title: widget.title),
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
    _chewieController.addListener(_videoListener);
    _chewieController.enterFullScreen();
    super.initState();
  }

  @override
  void deactivate() {
    // delayed(() async {
    //   await SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.portraitUp,
    //   ]);
    // });
    // _chewieController.dispose();
    // _chewieController.removeListener(_videoListener);
    // _controller.dispose();
    super.deactivate();
  }

  @override
  void dispose() {
    // delayed(() async {
    //   await SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.portraitUp,
    //   ]);
    // });
    _chewieController.dispose();
    _chewieController.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  _videoListener() {
    if (!_chewieController.isFullScreen) {
      _chewieController.removeListener(_videoListener);
      _chewieController.dispose();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: _chewieController);
  }
}
