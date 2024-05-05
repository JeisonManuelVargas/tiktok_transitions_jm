import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:tiktok_transitions_jm/src/utils/model/loading_builder.dart';

class VideoPlayerWidget extends StatefulWidget {
  final VideoPlayerModel videoPlayerModel;

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
  Widget build(BuildContext context) => Container(
    alignment: Alignment.center,
    height: double.infinity,
    width: double.infinity,
    child: AspectRatio(
      aspectRatio: widget.videoPlayerModel.controller!.value.aspectRatio,
      child: VideoPlayer(widget.videoPlayerModel.controller!),
    ),
  );

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerModel.controller!.pause();
  }
}
