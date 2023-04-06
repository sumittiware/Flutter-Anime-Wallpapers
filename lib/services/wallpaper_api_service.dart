import 'dart:convert';

import 'package:http/http.dart' as http;

class WallpaperApiService {
  Future<List<dynamic>> getWallpapers(String category) async {
    try {
      final response = await http.post(
        Uri.parse("https://api.waifu.pics/many/sfw/$category"),
        body: json.encode(
          {
            'exclude': [],
          },
        ),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final result = json.decode(response.body);

      return result['files'];
    } catch (_) {
      print("ERROR : $_");
      throw Exception("Unable to fetch wallpepers");
    }
  }
}
