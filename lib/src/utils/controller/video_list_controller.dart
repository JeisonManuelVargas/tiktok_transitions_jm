import 'package:flutter/cupertino.dart';

class VideoListController extends ChangeNotifier {
  List<String> _urlList = [];

  List<String> get urlList => _urlList;

  set urlList(List<String> list) {
    _urlList = list;
    notifyListeners();
  }

  addUrlList(List<String> list) {
    _urlList = [..._urlList,...list];
    notifyListeners();
  }
}
