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
  void initState() {
    super.initState();
    Future.microtask(() => context.read<AnImagesProvider>().getImages());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: Column(
        children: const [
          Categories(),
          Expanded(
            child: ImageGrid(),
          ),
        ],
      ),
    );
  }
}
