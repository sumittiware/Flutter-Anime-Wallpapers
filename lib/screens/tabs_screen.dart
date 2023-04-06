import 'package:animages/provider/animagesprovider.dart';
import 'package:animages/screens/homepage.dart';
import 'package:animages/screens/search_screen.dart';
import 'package:animages/screens/setting_screen.dart';
import 'package:animages/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ScreenState {
  home,
  search,
  user,
}

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  ScreenState _state = ScreenState.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: bgColor,
      title: const Text(
        "Waifu Wallpapers",
        style: TextStyle(
          fontFamily: "DancingScript",
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      actions: [
        Consumer<AnImagesProvider>(builder: (_, provider, __) {
          return Badge.count(
            count: provider.savedImages.length,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_rounded),
            ),
          );
        })
      ],
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _buildTabs(),
        _buildTabBar(),
      ],
    );
  }

  Widget _buildTabs() {
    switch (_state) {
      case ScreenState.home:
        return const HomePage();
      case ScreenState.search:
        return const SearchScreen();
      case ScreenState.user:
        return const SettingScreen();
      default:
        return Container();
    }
  }

  Widget _buildTabBar() {
    final size = MediaQuery.of(context).size;
    return Positioned(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        width: size.width * 0.8,
        height: 60,
        decoration: BoxDecoration(
          color: bgColor.withOpacity(0.7),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTabItem(
              ScreenState.home,
              Icons.home_rounded,
            ),
            _buildTabItem(
              ScreenState.search,
              Icons.search_rounded,
            ),
            _buildTabItem(
              ScreenState.user,
              Icons.settings_rounded,
            ),
          ],
        ),
      ),
      bottom: 40,
    );
  }

  Widget _buildTabItem(ScreenState state, IconData icon) {
    return GestureDetector(
      onTap: () => setState(() {
        _state = state;
      }),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _state == state ? primaryColor : Colors.transparent,
        ),
        child: Icon(
          icon,
          color: _state == state ? Colors.white : primaryColor,
        ),
      ),
    );
  }
}
