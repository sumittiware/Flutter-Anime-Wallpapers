import 'package:animages/provider/animagesprovider.dart';
import 'package:animages/styles/colors.dart';
import 'package:animages/widgets/image_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageGrid extends StatefulWidget {
  const ImageGrid({Key? key}) : super(key: key);

  @override
  _ImageGridState createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  @override
  Widget build(BuildContext context) {
    final aniProvider = Provider.of<AnImagesProvider>(context);
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: (aniProvider.status == DataStatus.loading)
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    mainAxisSpacing: 6.00,
                    crossAxisSpacing: 6.0),
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(4.0),
                itemCount: aniProvider.images.length,
                itemBuilder: (context, index) {
                  return ImageCard(index: index);
                },
              ));
  }
}
