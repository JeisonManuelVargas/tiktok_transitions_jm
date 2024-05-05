import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

typedef VideoPlayerManagerBuilder = Widget Function(
    BuildContext context,
    Widget body,
    VideoPlayerModel videoPlayer,
    );

typedef LoadingBuilder = Widget Function(BuildContext context);

class VideoPlayerModel {
  final int index;
  final String urlVideo;
  final VideoPlayerController? controller;

  VideoPlayerModel({
    this.controller,
    required this.index,
    required this.urlVideo,
  });

  VideoPlayerModel initController(Function reset, int index) =>
      VideoPlayerModel(
        urlVideo: urlVideo,
        index: index,
        controller: VideoPlayerController.networkUrl(
          Uri.parse(urlVideo),
          videoPlayerOptions: VideoPlayerOptions(),
        )..initialize().then(
              (value) => reset(),
        ),
      );

  VideoPlayerModel disposeController() {
    controller!.dispose();
    return VideoPlayerModel(
      urlVideo: urlVideo,
      controller: null,
      index: index,
    );
  }
}
