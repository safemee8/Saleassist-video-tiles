import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class SaleAssisstChacheManger {
  SaleAssisstChacheManger._privateConstructor() {
    _init();
  }
  static final SaleAssisstChacheManger _instance =
      SaleAssisstChacheManger._privateConstructor();
  factory SaleAssisstChacheManger() => _instance;

  CacheManager? kCacheManager;

  void _init() {
    const kReelCacheKey = "reelsCacheKey";
    kCacheManager = CacheManager(
      Config(
        kReelCacheKey,
        stalePeriod: const Duration(days: 7),
        maxNrOfCacheObjects: 100,
        repo: JsonCacheInfoRepository(databaseName: kReelCacheKey),
        fileService: HttpFileService(),
      ),
    );
  }

  Future<FileInfo?> getFileFromCache(String url) async {
    return await kCacheManager?.getFileFromCache(url);
  }

  Future<FileInfo> uploadToCache(String url) async {
    return await kCacheManager!.downloadFile(url);
  }

  Future<void> emptyCache() async {
    await kCacheManager?.emptyCache();
  }
}
