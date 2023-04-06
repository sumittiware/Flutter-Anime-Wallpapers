import 'package:animages/provider/animagesprovider.dart';
import 'package:animages/services/wallpaper_service_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

showWallpaperBottomSheet(BuildContext context) {
  final provider = Provider.of<AnImagesProvider>(context, listen: false);
  final image = provider.images[provider.currentIndex];
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        height: 300,
        child: Column(
          children: [
            buildTile(
                iconsData: Icons.wallpaper,
                title: "Home Screen",
                onTap: () => WallpaperServiceHandler.setWallpaper(image, 0)),
            buildTile(
                iconsData: Icons.wallpaper,
                title: "Lock Screen",
                onTap: () => WallpaperServiceHandler.setWallpaper(image, 1)),
            buildTile(
                iconsData: Icons.wallpaper,
                title: "Both Screens",
                onTap: () => WallpaperServiceHandler.setWallpaper(image, 2)),
          ],
        ),
      );
    },
  );
}

Widget buildTile({IconData? iconsData, String? title, Function()? onTap}) {
  return ListTile(
    leading: Icon(iconsData!),
    title: Text(title!),
    onTap: onTap,
  );
}

showCustomSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
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
    ),
  );
}
