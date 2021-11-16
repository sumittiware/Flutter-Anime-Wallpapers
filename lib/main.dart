import 'package:animages/animagesprovider.dart';
import 'package:animages/homepage.dart';
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AnImages',
        theme: ThemeData(
            primarySwatch: Colors.red, scaffoldBackgroundColor: Colors.black),
        home: const HomePage(),
      ),
    );
  }
}
