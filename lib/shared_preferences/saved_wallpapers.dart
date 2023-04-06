import 'package:shared_preferences/shared_preferences.dart';

const storageKey = 'SAVED_WALLPAPERS';

class LocalWallpaperStorage {
  static Future<List<String>> getSavedWallpapers() async {
    final prefs = await SharedPreferences.getInstance();

    final wallpapers = prefs.getStringList(storageKey);

    if (wallpapers != null) {
      return wallpapers;
    }
    return [];
  }

  static Future<void> addToSavedWallpapers(String link) async {
    final prefs = await SharedPreferences.getInstance();
    late List<String> wallpapers;
    wallpapers = prefs.getStringList(storageKey) ?? [];

    wallpapers.add(link);
    await prefs.setStringList(storageKey, wallpapers);
    return;
  }
}
