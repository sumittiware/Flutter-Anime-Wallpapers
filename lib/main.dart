import 'package:animages/provider/animagesprovider.dart';
import 'package:animages/screens/homepage.dart';
import 'package:animages/screens/tabs_screen.dart';
import 'package:animages/services/wallpaper_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AnImagesProvider(WallpaperApiService()),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "Roboto",
        ),
        debugShowCheckedModeBanner: false,
        title: 'Waifu Wallpapers',
        home: const TabsScreen(),
      ),
    );
  }
}
