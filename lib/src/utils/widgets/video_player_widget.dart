import 'package:flutter/material.dart';
import 'package:tiktok_transitions_jm/src/utils/model/tik_tok_model.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final TikTokModel videoPlayerModel;

  const VideoPlayerWidget({
    super.key,
    required this.videoPlayerModel,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  @override
  void initState() {
    super.initState();
    widget.videoPlayerModel.controller!.play();
  }

  @override
  Widget build(BuildContext context) =>
      VideoPlayer(widget.videoPlayerModel.controller!);

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerModel.controller!.pause();
  }
}
