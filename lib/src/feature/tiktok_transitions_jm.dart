import 'package:flutter/material.dart';
import 'package:tiktok_transitions_jm/src/utils/model/tik_tok_model.dart';
import 'package:tiktok_transitions_jm/src/utils/widgets/loading_page.dart';
import 'package:tiktok_transitions_jm/src/utils/model/loading_builder.dart';
import 'package:tiktok_transitions_jm/src/utils/model/tik_tok_manager_builder.dart';
import 'package:tiktok_transitions_jm/src/utils/controller/video_list_controller.dart';

class _TikTokTransitionsJmState extends State<TikTokTransitionsJm> {
  late int _currentPage = 0;
  bool activatorFirstTime = true;
  late PageController _controller;
  late List<int> currentIndexList;
  late List<TikTokModel> listVideoModel = [];

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _controller = PageController();
    _controller.addListener(() => _controllerManager());
    setState(() => currentIndexList = _generateListIndex(0));

    widget.urlListController.addListener(() {});

    _initialVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: PageView.builder(
          controller: _controller,
          scrollDirection: Axis.vertical,
          itemCount: listVideoModel.length,
          itemBuilder: (context, index) => LoadingPage(
            builder: widget.builder,
            loadingBuilder: widget.loadingBuilder,
            videoPlayerModel: listVideoModel[index],
          ),
        ),
      ),
    );
  }

  _controllerManager() {
    final newPage = _controller.page!.round();
    if (newPage != _currentPage) {
      final newIndexList = _generateListIndex(newPage);
      final thrownIndex = _compareList(currentIndexList, newIndexList);
      final indexAdded = _compareList(newIndexList, currentIndexList);
      setState(() {
        _currentPage = newPage;
        currentIndexList = newIndexList;
      });
      if (indexAdded != -1) {
        listVideoModel[indexAdded] = listVideoModel[indexAdded].initController(
          () => setState(() {}),
        );
      }
      if (thrownIndex != -1)
        listVideoModel[thrownIndex] =
            listVideoModel[thrownIndex].disposeController();
    }
  }

  int _compareList(List<int> firstList, List<int> secondList) =>
      firstList.firstWhere(
        (element) => !secondList.contains(element),
        orElse: () => -1,
      );

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

  addElementsTiktokModelList() {
    for (var item in widget.urlListController.urlList.asMap().entries) {
      final findItem = listVideoModel.where((element) => element.urlVideo == item.value).toList();
      if (findItem.isEmpty) {
        listVideoModel.add(TikTokModel(urlVideo: item.value, index: item.key));
      }
    }
    if (activatorFirstTime) _initialVideos();
  }

  _initialVideos() async {
    for (var index in currentIndexList) {
      if (listVideoModel.isNotEmpty && listVideoModel.length > index) {
        listVideoModel[index] = listVideoModel[index].initController(
          () => setState(() {}),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class TikTokTransitionsJm extends StatefulWidget {
  final LoadingBuilder loadingBuilder;
  final TikTokManagerBuilder builder;
  final VideoListController urlListController;

  const TikTokTransitionsJm({
    super.key,
    required this.builder,
    required this.loadingBuilder,
    required this.urlListController,
  });

  @override
  State<TikTokTransitionsJm> createState() => _TikTokTransitionsJmState();
}
