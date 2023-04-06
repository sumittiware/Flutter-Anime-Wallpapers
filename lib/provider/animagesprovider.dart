import 'dart:convert';

import 'package:animages/services/wallpaper_api_service.dart';
import 'package:animages/shared_preferences/saved_wallpapers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum DataStatus { loading, loaded }

class AnImagesProvider with ChangeNotifier {
  WallpaperApiService _wallpaperService;

  AnImagesProvider(this._wallpaperService);

  DataStatus status = DataStatus.loading;
  List<dynamic> _images = [];
  List<String> _savedImages = [];

  int? _currentIndex;
  String _currentCategory = "waifu";

  List<String> sfwCat = [
    "waifu",
    "neko",
    "shinobu",
    "megumin",
  ];

  // getters
  List<String> get images => [..._images];
  List<String> get savedImages => [..._savedImages];
  List<String> get currentCategories => sfwCat;
  int get currentIndex => _currentIndex ?? 0;
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
    setDataStatus(
      DataStatus.loading,
    );
  }

  Future<void> getImages() async {
    try {
      _images = await _wallpaperService.getWallpapers(currentCategory);
      setDataStatus(
        DataStatus.loaded,
      );
    } catch (err) {
      throw err.toString();
    }
  }

  Future<List<String>> getSavedImages() async {
    if (_savedImages.isEmpty) {
      _savedImages = await LocalWallpaperStorage.getSavedWallpapers();
    }
    notifyListeners();
    return [..._savedImages];
  }

  Future<void> addToSavedImages(int index) async {
    final link = _images[index];
    _savedImages.add(link);
    await LocalWallpaperStorage.addToSavedWallpapers(link);
    notifyListeners();
  }
}
