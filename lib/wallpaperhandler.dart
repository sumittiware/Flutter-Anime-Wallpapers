import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:gallery_saver/gallery_saver.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:wallpaper_manager/wallpaper_manager.dart';

Future<bool> requestPermissions() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
    status = await Permission.storage.status;
  }
  return status.isGranted;
}

Future<Directory> getDownloadDirectory() async {
  if (Platform.isAndroid) {
    Directory? directory = await getExternalStorageDirectory();
    String newPath = "";
    List<String> paths = directory!.path.split("/");
    for (int x = 1; x < paths.length; x++) {
      String folder = paths[x];
      if (folder != "Android") {
        newPath += "/" + folder;
      } else {
        break;
      }
    }
    String enddir = "/Waifu Wallpapers/";
    newPath = newPath + enddir;
    var dir = Directory(newPath);
    bool direxists = await dir.exists();
    if (!direxists) {
      await dir.create(recursive: true);
    }
    return dir;
  }
  throw "Platform not supported";
}

class WallpaperHandler {
  static Future<String> get _localPath async {
    final directory = await getDownloadsDirectory();
    return directory!.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/');
  }

  static Future<String> saveImage(String image) async {
    try {
      var permissions = await requestPermissions();
      var dir = await getDownloadDirectory();
      final cacheFile = await DefaultCacheManager().getSingleFile(image);
      if (!permissions) throw "Storage permission not granted";
      final file = File(dir.path + cacheFile.basename.split("/").last);
      cacheFile.copy(file.path);
      return file.path;
    } catch (err) {
      throw "Error occured";
    }
  }

  static Future<String> setWallpaperFromFile(
      {required String image, required int screens}) async {
    String result;
    var file = await DefaultCacheManager().getSingleFile(image);
    // file.
    try {
      result = await WallpaperManager.setWallpaperFromFile(file.path, screens);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
    return result;
  }

  // static Future<String> saveImage(String image) async {
  //   try {
  //     await GallerySaver.saveImage(image);
  //     return "Image Saved!!";
  //   } catch (err) {
  //     throw err.toString();
  //   }
  // }
}
