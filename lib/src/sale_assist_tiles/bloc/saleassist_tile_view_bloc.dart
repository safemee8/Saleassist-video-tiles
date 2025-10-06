import 'dart:async';
import 'dart:collection';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:saleassist_video_tiles/core/repository/tiles_api_repository.dart';
import 'package:saleassist_video_tiles/core/services/cache/chache_manger.dart';
import 'package:saleassist_video_tiles/core/services/networking/api/api_response.dart';
import 'package:saleassist_video_tiles/src/sale_assist_tiles/bloc/saeassist_tile_view_state.dart';
import 'package:saleassist_video_tiles/src/sale_assist_tiles/bloc/saleassist_tile_view_event.dart';
import 'package:saleassist_video_tiles/src/sale_assist_tiles/model/shorts_model/shorts_model.dart';
import 'package:video_player/video_player.dart';

class SaleassistTileBloc
    extends Bloc<SaleassistTileEvent, SaleassistTileState> {
  final TilesApiRepository tilesApiRepository;
  final SaleAssisstChacheManger chacheManger; // keeping your type name as-is

  /// Limit concurrent cache writes so we don’t spike I/O/network or hit
  /// too many simultaneous HTTP requests. Tune as needed.
  final int _prefetchConcurrency;

  SaleassistTileBloc({
    required this.tilesApiRepository,
    required this.chacheManger,
    int prefetchConcurrency = 4,
  })  : _prefetchConcurrency = prefetchConcurrency,
        super(VideoLoading()) {
    on<SaleassistTileLoadEvent>(_loadVideos);
  }

  FutureOr<void> _loadVideos(
      SaleassistTileLoadEvent event, Emitter<SaleassistTileState> emit) async {
    emit(VideoLoading());
    try {
      final APIResponse response =
          await tilesApiRepository.getVideoTiles(playlistId: event.playlistId);

      if (response is! SuccessResponse) {
        emit(VideoLoadFailure('Something went wrong'));
        return;
      }

      final shortsModel = ShortsModel.fromMap(response.rawData);

      final mediaList = shortsModel.media ?? const [];
      if (mediaList.isEmpty) {
        emit(VideoLoadSuccess(fileInfos: const [], shortsModel: shortsModel));
        return;
      }

      // Build ordered pairs and a deduped set of all URLs to cache
      final List<_ShortPair> pairs = [];
      final LinkedHashSet<String> uniqueUrls = LinkedHashSet();

      for (final m in mediaList) {
        final fullUrl = (m.media ?? '').trim();
        final shortUrl =
            ((m.shortVideoUrl ?? '').isEmpty ? fullUrl : m.shortVideoUrl!)
                .trim();

        if (fullUrl.isEmpty) continue;
        pairs.add(_ShortPair(full: fullUrl, short: shortUrl));

        uniqueUrls.add(fullUrl);
        if (shortUrl.isNotEmpty) uniqueUrls.add(shortUrl);
      }

      // Prefetch with simple throttling
      await _prefetchAll(uniqueUrls.toList());

      // Collect the *short* variant (fallback to full) in original order
      final List<Future<FileInfo>> fetchInfos = [];
      for (final p in pairs) {
        final url = p.short.isNotEmpty ? p.short : p.full;
        FileInfo? info = await chacheManger.getFileFromCache(url);
        if (info != null) {
          fetchInfos.add(Future.value(info));
        }
      }

      final shorts = await Future.wait(fetchInfos);
      emit(VideoLoadSuccess(fileInfos: shorts, shortsModel: shortsModel));
    } catch (e, st) {
      log('SaleassistTileBloc.loadVideos error: $e\n$st');
      emit(VideoLoadFailure(e.toString()));
    }
  }

  /// Ensures a single URL is present in cache; downloads if missing.
  Future<void> _ensureCached(String url) async {
    if (url.isEmpty) return;
    final exists = await chacheManger.getFileFromCache(url);
    if (exists == null) {
      try {
        await chacheManger.uploadToCache(url);
        log('Cached: $url');
      } catch (e) {
        // Don’t fail the whole batch for one URL—log and continue.
        log('Failed to cache $url -> $e');
      }
    } else {
      // already cached; no-op
      // log('Already cached: $url'); // keep noisy logs off in prod
    }
  }

  /// Prefetch all URLs with basic concurrency control.
  Future<void> _prefetchAll(List<String> urls) async {
    if (urls.isEmpty) return;

    final queue = Queue<String>()..addAll(urls);
    final List<Future<void>> inFlight = [];

    void startNext() {
      if (queue.isEmpty) return;
      final url = queue.removeFirst();
      final f = _ensureCached(url).whenComplete(() {
        // When one finishes, if more remain, start the next.
        startNext();
      });
      inFlight.add(f);
    }

    // Bootstrap up to concurrency limit
    final starters = _prefetchConcurrency.clamp(1, urls.length);
    for (int i = 0; i < starters; i++) {
      startNext();
    }

    await Future.wait(inFlight);
  }
}

class _ShortPair {
  final String full;
  final String short;
  const _ShortPair({required this.full, required this.short});
}
