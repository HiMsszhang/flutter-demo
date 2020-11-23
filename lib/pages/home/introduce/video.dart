import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:chewie/chewie.dart';
import 'package:molan_edu/widgets/custom_controls.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:molan_edu/apis/introduce.dart';
import 'package:molan_edu/models/IntroduceModel.dart';

class IntroduceVideoPage extends StatefulWidget {
  final IntroduceModel data;
  const IntroduceVideoPage({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  _IntroduceVideoPageState createState() => _IntroduceVideoPageState();
}

class _IntroduceVideoPageState extends State<IntroduceVideoPage> with UtilsMixin {
  VideoPlayerController _controller;
  ChewieController _chewieController;
  Future<void> _future;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.data.videoUrl);
    if (_controller.value.hasError) {
      print(_controller.value.errorDescription);
    }
    _future = initVideoPlayer();
    delayed(() async {
      await _addWatchNum();
    });
  }

  @override
  void dispose() {
    _chewieController.dispose();
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
        aspectRatio: _controller.value.aspectRatio,
        allowFullScreen: false,
        allowedScreenSleep: false,
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        customControls: CustomControls(
          title: widget.data.title ?? '',
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

  _back() async {
    NavigatorUtils.pop(context);
  }

  Future<bool> _onPop() async {
    await _back();
    return new Future.value(false);
  }

  _addWatchNum() async {
    try {
      await IntroduceAPI.watch(videoId: widget.data.id);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPop,
      child: Scaffold(
        body: SafeArea(
          top: true,
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
        ),
      ),
    );
  }
}
