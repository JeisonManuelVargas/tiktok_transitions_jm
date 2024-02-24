import 'package:video_player/video_player.dart';

class TikTokModel {
  final String urlVideo;
  final VideoPlayerController? controller;

  TikTokModel({this.controller, required this.urlVideo});

  TikTokModel initController(Function reset) => TikTokModel(
        urlVideo: urlVideo,
        controller: VideoPlayerController.networkUrl(Uri.parse(urlVideo))
          ..initialize().then((value) => reset()),
      );

  TikTokModel disposeController() {
    controller!.dispose();
    return TikTokModel(urlVideo: urlVideo, controller: null);
  }
}
