import 'package:flutter/material.dart';
import 'package:tiktok_transitions_jm/src/utils/model/loading_builder.dart';
import 'package:tiktok_transitions_jm/src/utils/model/tik_tok_model.dart';
import 'package:tiktok_transitions_jm/src/utils/model/video_player_manager_builder.dart';
import 'package:tiktok_transitions_jm/src/utils/widgets/video_player_widget.dart';

class LoadingPage extends StatelessWidget {
  final LoadingBuilder loadingBuilder;
  final TikTokModel videoPlayerModel;
  final VideoPlayerManagerBuilder builder;

  const LoadingPage({
    super.key,
    required this.builder,
    required this.loadingBuilder,
    required this.videoPlayerModel,
  });

  @override
  Widget build(BuildContext context) {
    if (videoPlayerModel.controller != null &&
        videoPlayerModel.controller!.value.isInitialized) {
      return builder(
        context,
        VideoPlayerWidget(videoPlayerModel: videoPlayerModel),
        videoPlayerModel,
      );
    }
    return loadingBuilder(context);
  }
}
