import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class WallpaperServiceHandler {
  static const platform = MethodChannel("com.sgt.animewallpapers");

  static Future<void> setWallpaper(String url, int type) async {
    try {
      final String result = await platform.invokeMethod(
        "setWallpaper",
        {
          "imageUrl": url,
          "screen": type.toString(),
        },
      );
      debugPrint(result);
    } on PlatformException catch (err) {
      debugPrint(err.message);
    }
  }

  static Future<void> saveWallpaper(String url) async {
    try {
      final String result = await platform.invokeMethod(
        "saveWallpaper",
        {
          "imageUrl": url,
        },
      );
      debugPrint(result);
    } on PlatformException catch (err) {
      debugPrint(err.message);
    }
  }
}
