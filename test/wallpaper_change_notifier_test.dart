import 'package:animages/provider/animagesprovider.dart';
import 'package:animages/services/wallpaper_api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// class MockWallpaperApiService implements WallpaperApiService {
//   @override
//   Future<List> getWallpapers(String category) async {
//     return [
//       'link1',
//       'link2',
//       'link3',
//     ];
//   }
// }

// Extending the class from the mock class, we do now have to implemnent any of the methods
class MockWallpaperApiService extends Mock implements WallpaperApiService {}

void main() {
  // system under test
  late AnImagesProvider sut;
  late MockWallpaperApiService mockWallpaperApiService;

  setUp(() {
    mockWallpaperApiService = MockWallpaperApiService();
    sut = AnImagesProvider(mockWallpaperApiService);
  });

  test("initial values are correct", () {
    expect(sut.images, []);
    expect(sut.currentIndex, 0);
    expect(sut.status, DataStatus.loading);
    expect(sut.currentCategory, "waifu");
  });

  group(
    'getArticles',
    () {
      void arrangeWallpaperServiceReturns() {
        when(() => mockWallpaperApiService.getWallpapers(sut.currentCategory))
            .thenAnswer((_) async => ['link1', 'link2', 'link3']);
      }

      test(
        'gets wallpapers using the WallPaperApiService',
        () async {
          arrangeWallpaperServiceReturns();
          await sut.getImages();
          verify(() =>
                  mockWallpaperApiService.getWallpapers(sut.currentCategory))
              .called(1);
        },
      );

      test(
        '''
            Loading data
            sets wallpapers to the ones from the service
      ''',
        () async {
          arrangeWallpaperServiceReturns();
          expect(sut.status, DataStatus.loading);
          await sut.getImages();
          expect(sut.images, ['link1', 'link2', 'link3']);
          expect(sut.status, DataStatus.loaded);
        },
      );
    },
  );
}
