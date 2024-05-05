import 'package:flutter/material.dart';
import 'package:tiktok_transitions_jm/src/utils/controller/video_list_controller.dart';
import 'package:tiktok_transitions_jm/src/utils/model/loading_builder.dart';
import 'package:tiktok_transitions_jm/src/utils/widgets/loading_page.dart';

class TikTokTransitionsJm extends StatefulWidget {
  final PageController controller;
  final LoadingBuilder loadingBuilder;
  final VideoPlayerManagerBuilder builder;
  final VideoListController videoListController;

  const TikTokTransitionsJm({
    super.key,
    required this.builder,
    required this.controller,
    required this.loadingBuilder,
    required this.videoListController,
  });

  @override
  State<TikTokTransitionsJm> createState() =>
      _TikTokTransitionsJmState();
}

class _TikTokTransitionsJmState extends State<TikTokTransitionsJm> {
  late int _currentPage;
  bool activatorFirstTime = true;
  late List<int> currentIndexList;
  final List<VideoPlayerModel> listVideoModel = [];

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    widget.controller.addListener(() => controllerManager());
    setState(() => currentIndexList = _generateListIndex(0));
    widget.videoListController
        .addListener(() => fromStringToVideoPlayerModel());
  }

  @override
  Widget build(BuildContext context) {
    return widget.videoListController.urlList.isNotEmpty
        ? PageView.builder(
      controller: widget.controller,
      scrollDirection: Axis.vertical,
      itemCount: listVideoModel.length,
      itemBuilder: (context, index) => LoadingPage(
        builder: widget.builder,
        loadingBuilder: widget.loadingBuilder,
        videoPlayerModel: listVideoModel[index],
      ),
    )
        : Center(
      child: Text(
        "Esta vacio",
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black87,
              blurRadius: 5,
              offset: Offset(0, 1)
            )
          ]
        ),
      ),
    );
  }

  fromStringToVideoPlayerModel() {
    for (var item in widget.videoListController.urlList.asMap().entries) {
      final findItem = listVideoModel
          .where((element) => element.urlVideo == item.value)
          .toList();
      if (findItem.isEmpty) {
        listVideoModel
            .add(VideoPlayerModel(urlVideo: item.value, index: item.key));
      }
    }
    if (activatorFirstTime) _initialVideos();
  }

  controllerManager() {
    final newPage = widget.controller.page!.round();
    if (newPage != _currentPage) {
      final newIndexList = _generateListIndex(newPage);
      final thrownIndex = _compareList(currentIndexList, newIndexList);
      setState(() {
        _currentPage = newPage;
        currentIndexList = newIndexList;
      });
      newIndexList.forEach(
            (index) {
          if (listVideoModel[index].controller == null) {
            listVideoModel[index] = listVideoModel[index].initController(
                  () => setState(() {}),
              index,
            );
          }
        },
      );

      if (thrownIndex != -1)
        listVideoModel[thrownIndex] =
            listVideoModel[thrownIndex].disposeController();
    }
  }

  int _compareList(List<int> firstList, List<int> secondList) {
    final index = firstList.firstWhere(
            (element) => !secondList.contains(element),
        orElse: () => -1);
    return index;
  }

  List<int> _generateListIndex(int index) {
    List<int> listIndex = [];
    for (int i = index - 2; i <= index + 2; i++) {
      listIndex.add(i);
    }
    listIndex.removeWhere((element) => element < 0);
    if (listVideoModel.isNotEmpty) {
      listIndex.removeWhere((element) => element > listVideoModel.length - 1);
    }
    return listIndex;
  }

  _initialVideos() async {
    for (var index in currentIndexList) {
      if (listVideoModel.isNotEmpty && listVideoModel.length > index) {
        listVideoModel[index] = listVideoModel[index].initController(
              () => setState(() {}),
          index,
        );
      }
    }
    setState(() => activatorFirstTime = false);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(() => controllerManager());
  }
}
