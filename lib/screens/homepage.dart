import 'package:animages/provider/animagesprovider.dart';
import 'package:animages/styles/colors.dart';
import 'package:animages/widgets/category_list.dart';
import 'package:animages/widgets/image_grid.dart';
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
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("Waifu Wallpaper"),
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
          Column(children: const [Categories(), Expanded(child: ImageGrid())]),
    );
  }
}
