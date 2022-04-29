import 'package:animages/provider/animagesprovider.dart';
import 'package:animages/screens/imageview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageCard extends StatefulWidget {
  final int index;
  const ImageCard({Key? key, required this.index}) : super(key: key);

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnImagesProvider>(builder: (_, provider, __) {
      return GridTile(
          child: GestureDetector(
              onTap: () {
                provider.setCurrentImage(widget.index);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ImageView()));
              },
              child: Hero(
                tag: provider.images[widget.index],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(provider.images[widget.index],
                      fit: BoxFit.cover),
                ),
              )));
    });
  }
}
