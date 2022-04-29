import 'package:animages/provider/animagesprovider.dart';
import 'package:animages/screens/homepage.dart';
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
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: AnImagesProvider())],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Waifu Wallpapers',
        home: HomePage(),
      ),
    );
  }
}
