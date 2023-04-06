import 'package:animages/provider/animagesprovider.dart';
import 'package:animages/screens/homepage.dart';
import 'package:animages/services/wallpaper_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockWallpaperApiService extends Mock implements WallpaperApiService {}

void main() {
  late AnImagesProvider sut;
  late MockWallpaperApiService mockWallpaperApiService;

  setUp(() {
    mockWallpaperApiService = MockWallpaperApiService();
    sut = AnImagesProvider(mockWallpaperApiService);
  });

  final wallpapersLists = [
    'link1',
    'link2',
    'link3',
  ];

  void arrangeWallpaperServiceReturns() {
    when(() => mockWallpaperApiService.getWallpapers(sut.currentCategory))
        .thenAnswer((_) async => wallpapersLists);
  }

  void arrangeWallpaperServiceReturnsAfter2sec() {
    when(() => mockWallpaperApiService.getWallpapers(sut.currentCategory))
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      return wallpapersLists;
    });
  }

  Widget createWidgetUnderTest() {
    return ChangeNotifierProvider(
      create: (context) => AnImagesProvider(mockWallpaperApiService),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "Roboto",
        ),
        debugShowCheckedModeBanner: false,
        title: 'Waifu Wallpapers',
        home: const HomePage(),
      ),
    );
  }

  testWidgets('title is displayed', (tester) async {
    arrangeWallpaperServiceReturns();
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text('Waifu Wallpaper'), findsOneWidget);
  });

  group('WallPapers Page', () {
    testWidgets('Wallpapers are loading', (tester) async {
      arrangeWallpaperServiceReturnsAfter2sec();
      await tester.pumpWidget(createWidgetUnderTest());
      // pump() will trigger the widget to rebuild
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      // will wait at the following line till all the animations are finished,
      // for this case the animations are circularprogress indicator
      await tester.pumpAndSettle();
    });
  });
}
