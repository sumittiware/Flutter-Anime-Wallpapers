import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum DataStatus { loading, loaded }

class AnImagesProvider with ChangeNotifier {
  AnImagesProvider() {
    getImages();
  }

  DataStatus status = DataStatus.loading;
  List<dynamic> _images = [];

  int? _currentIndex;
  String _currentType = "sfw";
  String _currentCategory = "waifu";

  List<String> sfwCat = [
    "waifu",
    "neko",
    "shinobu",
    "megumin",
  ];

  List<String> nsfwCat = [
    "waifu",
    "neko",
    "trap",
  ];

  // getters
  List<String> get images => [..._images];
  List<String> get currentCategories =>
      (_currentType == "sfw") ? sfwCat : nsfwCat;
  int get currentIndex => _currentIndex!;
  String get currentType => _currentType;
  String get currentCategory => _currentCategory;

  // setters
  void setDataStatus(DataStatus _status) {
    status = _status;
    notifyListeners();
  }

  setCurrentImage(int index) {
    if (index >= _images.length) return;
    _currentIndex = index;
    notifyListeners();
  }

  setCategory(String category) {
    _currentCategory = category;
    getImages();
    setDataStatus(DataStatus.loading);
  }

  Future<void> getImages() async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://api.waifu.pics/many/$_currentType/$_currentCategory"),
          body: json.encode({'exclude': []}),
          headers: {
            'Content-Type': 'application/json',
          });

      final result = json.decode(response.body);
      _images = result['files'];
      setDataStatus(DataStatus.loaded);
    } catch (err) {
      throw err.toString();
    }
  }

  void toogleTypes() {
    if (_currentType == "sfw") {
      _currentType = "nsfw";
      _currentCategory = "waifu";
    } else {
      _currentType = "sfw";
      _currentCategory = "waifu";
    }
    getImages();
    setDataStatus(DataStatus.loading);
  }
}
