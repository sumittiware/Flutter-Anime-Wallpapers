// import 'dart:ui';
import 'package:animages/provider/animagesprovider.dart';
import 'package:animages/services/wallpaper_service_handler.dart';
import 'package:animages/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageView extends StatefulWidget {
  const ImageView({Key? key}) : super(key: key);
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  Size? size;
  EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    size = mediaQuery.size;
    padding = mediaQuery.padding;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildWallpaper(),
          _buildBackButton(),
          _buildOptionsBar(),
        ],
      ),
    );
  }

  Widget _buildWallpaper() {
    return Consumer<AnImagesProvider>(
      builder: (_, provider, __) {
        return PageView.builder(
          onPageChanged: (index) => provider.setCurrentImage(index),
          itemCount: provider.images.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (_, __) {
            return Hero(
              tag: provider.images[provider.currentIndex],
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: size!.height - padding!.top,
                  width: size!.width,
                  child: Image.network(
                    provider.images[provider.currentIndex],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      child: _buildButton(
        Icons.arrow_back,
        () => Navigator.pop(context),
      ),
      top: padding!.top + 16,
      left: 16,
    );
  }

  _buildOptionsBar() {
    return Consumer<AnImagesProvider>(
      builder: (context, provider, _) {
        return Positioned(
          bottom: 40,
          child: Container(
            width: size!.width,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton(
                  Icons.favorite_border,
                  () {
                    provider.addToSavedImages(provider.currentIndex);
                  },
                ),
                _buildTextButton(
                  'APPLY',
                  () => showWallpaperBottomSheet(context),
                ),
                _buildButton(
                  Icons.download,
                  () => WallpaperServiceHandler.saveWallpaper(
                    provider.images[provider.currentIndex],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton(IconData icon, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildTextButton(String text, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
