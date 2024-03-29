import 'package:video_player/video_player.dart';

class TikTokModel {
  final int index;
  final String urlVideo;
  final VideoPlayerController? controller;

  TikTokModel({this.controller, required this.urlVideo, required this.index});

  TikTokModel initController(Function reset) => TikTokModel(
        index: index,
        urlVideo: urlVideo,
        controller: VideoPlayerController.networkUrl(Uri.parse(urlVideo))
          ..initialize().then((value) => reset()),
      );

  TikTokModel disposeController() {
    controller!.dispose();
    return TikTokModel(
      index: index,
      controller: null,
      urlVideo: urlVideo,
    );
  }
}
