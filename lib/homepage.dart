import 'package:animages/animagesprovider.dart';
import 'package:animages/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final aniProvider = Provider.of<AnImagesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Waifu Wallpaper"),
        centerTitle: true,
        actions: [
          GestureDetector(
              onTap: () => aniProvider.toogleTypes(),
              child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "18+",
                    style: TextStyle(fontSize: 18),
                  ))),
        ],
      ),
      body:
          Column(children: const [Categories(), Expanded(child: ImageCard())]),
    );
  }
}
