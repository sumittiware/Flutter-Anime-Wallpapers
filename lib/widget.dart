import 'package:animages/animagesprovider.dart';
import 'package:animages/imageview.dart';
import 'package:animages/wallpaperhandler.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageCard extends StatefulWidget {
  const ImageCard({Key? key}) : super(key: key);

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    final aniProvider = Provider.of<AnImagesProvider>(context);
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: (aniProvider.status == DataStatus.loading)
            ? const Center(
                child: CircularProgressIndicator(),
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
                  return GridTile(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageView(
                                    imgPath: aniProvider.images[index],
                                  )));
                    },
                    child: Hero(
                      tag: aniProvider.images[index],
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                              imageUrl: aniProvider.images[index],
                              placeholder: (context, url) => Container(
                                    color: const Color(0xfff5f8fd),
                                  ),
                              fit: BoxFit.cover)),
                    ),
                  ));
                },
              ));
  }
}

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final aniProvider = Provider.of<AnImagesProvider>(context);
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: List.generate(
                  aniProvider.currentCategories.length,
                  (index) => GestureDetector(
                        onTap: () => aniProvider
                            .setCategory(aniProvider.currentCategories[index]),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: (aniProvider.currentCategory ==
                                          aniProvider.currentCategories[index])
                                      ? Colors.red
                                      : Colors.white,
                                  width: 1),
                              color: (aniProvider.currentCategory ==
                                      aniProvider.currentCategories[index])
                                  ? Colors.red
                                  : Colors.transparent),
                          child: Text(
                            aniProvider.currentCategories[index],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ))),
        ));
  }
}

showWallpaperBottomSheet(BuildContext context, String image) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.wallpaper),
                title: const Text("Home Screen"),
                onTap: () => WallpaperHandler.setWallpaperFromFile(
                        image: image, screens: 1)
                    .then((value) {
                  Navigator.pop(context);
                  showCustomSnackBar(context, value);
                }),
              ),
              ListTile(
                leading: const Icon(Icons.wallpaper),
                title: const Text("Lock Screen"),
                onTap: () => WallpaperHandler.setWallpaperFromFile(
                        image: image, screens: 2)
                    .then((value) {
                  Navigator.pop(context);
                  showCustomSnackBar(context, value);
                }),
              ),
              ListTile(
                leading: const Icon(Icons.wallpaper),
                title: const Text("Both Screen"),
                onTap: () => WallpaperHandler.setWallpaperFromFile(
                        image: image, screens: 3)
                    .then((value) {
                  Navigator.pop(context);
                  showCustomSnackBar(context, value);
                }),
              ),
              ListTile(
                leading: const Icon(Icons.save_alt),
                title: const Text("Save to Gallery"),
                onTap: () => WallpaperHandler.saveImage(image).then((value) {
                  Navigator.pop(context);
                  showCustomSnackBar(context, value);
                }).catchError((err) {
                  Navigator.pop(context);
                  showCustomSnackBar(context, err.toString());
                }),
              ),
            ],
          ),
        );
      });
}

showCustomSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    margin: const EdgeInsets.all(16),
    backgroundColor: Colors.black54,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    duration: const Duration(seconds: 5),
  ));
}
