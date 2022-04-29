// import 'dart:ui';
import 'package:animages/provider/animagesprovider.dart';
import 'package:animages/widget.dart';
// import 'package:cached_network_image/cached_network_image.dart';
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
      body: Consumer<AnImagesProvider>(builder: (__, imageProvider, _) {
        return Stack(
          children: <Widget>[
            _buildWallpaper(),
            _buildBackButton(),
            _buildOptionsButton(),
          ],
        );
      }),
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
                  child: Image.network(provider.images[provider.currentIndex],
                      fit: BoxFit.cover),
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
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Stack(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xff1C1B1B).withOpacity(0.8),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24, width: 1),
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                      colors: [Color(0x36FFFFFF), Color(0x0FFFFFFF)],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight)),
              child: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
      top: padding!.top + 16,
      left: 16,
    );
  }

  Widget _buildOptionsButton() {
    return Positioned(
        bottom: 100,
        child: Container(
            height: size!.height - padding!.top,
            width: size!.width,
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () => showWallpaperBottomSheet(context),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff1C1B1B).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white24, width: 1),
                        borderRadius: BorderRadius.circular(40),
                        gradient: const LinearGradient(
                            colors: [Color(0x36FFFFFF), Color(0x0FFFFFFF)],
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.bottomRight)),
                    child: const Text(
                      "Set Wallpaper",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            )));
  }
}
