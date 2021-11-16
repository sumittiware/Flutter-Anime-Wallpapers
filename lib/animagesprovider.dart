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
  String _currentType = "sfw";
  String _currentCategory = "waifu";
  List<String> sfwCat = [
    "waifu",
    "neko",
    "shinobu",
    "megumin",
    "bully",
    "cuddle",
    "cry",
    "hug",
    "awoo",
    "kiss",
    "lick",
    "pat",
    "smug",
    "bonk",
    "yeet",
    "blush",
    "smile",
    "wave",
    "highfive",
    "handhold",
    "nom",
    "bite",
    "glomp",
    "slap",
    "kill",
    "kick",
    "happy",
    "wink",
    "poke",
    "dance",
    "cringe"
  ];
  List<String> nsfwCat = ["waifu", "neko", "trap", "blowjob"];

  List<String> get images {
    return [..._images];
  }

  List<String> get currentCategories {
    return (_currentType == "sfw") ? sfwCat : nsfwCat;
  }

  String get currentType {
    return _currentType;
  }

  String get currentCategory {
    return _currentCategory;
  }

  setCategory(String category) {
    _currentCategory = category;
    getImages();
    status = DataStatus.loading;
    notifyListeners();
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
      status = DataStatus.loaded;
      notifyListeners();
    } catch (err) {
      throw err.toString();
    }
  }

  toogleTypes() {
    if (_currentType == "sfw") {
      _currentType = "nsfw";
      _currentCategory = "waifu";
      status = DataStatus.loading;
      getImages();
    } else {
      _currentType = "sfw";
      _currentCategory = "waifu";
      status = DataStatus.loading;
      getImages();
    }
    notifyListeners();
  }
}
