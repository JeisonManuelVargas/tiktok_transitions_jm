import 'package:flutter/cupertino.dart';
import 'package:tiktok_transitions_jm/src/utils/model/tik_tok_model.dart';

typedef TikTokManagerBuilder = Widget Function(
    BuildContext context,
    Widget body,
    TikTokModel videoPlayer,
    );