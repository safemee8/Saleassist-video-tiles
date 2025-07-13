import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:saleassist_video_tiles/core/repository/tiles_api_repository.dart';
import 'package:saleassist_video_tiles/core/services/cache/chache_manger.dart';
import 'package:saleassist_video_tiles/core/services/networking/api/api_response.dart';
import 'package:saleassist_video_tiles/src/sale_assist_tiles/bloc/saeassist_tile_view_state.dart';
import 'package:saleassist_video_tiles/src/sale_assist_tiles/bloc/saleassist_tile_view_event.dart';
import 'package:saleassist_video_tiles/src/sale_assist_tiles/model/shorts_model/shorts_model.dart';
import 'package:saleassist_video_tiles/src/sale_assist_tiles/views/tiles/saleassist_tile_view.dart';
import 'package:saleassist_video_tiles/src/sale_assit_full_screen_view/view/sale_assist_full_screen.dart';
import 'package:video_player/video_player.dart';

class SaleassistTileBloc
    extends Bloc<SaleassistTileEvent, SaleassistTileState> {
  final TilesApiRepository tilesApiRepository;
  final SaleAssisstChacheManger chacheManger;
  SaleassistTileBloc({
    required this.tilesApiRepository,
    required this.chacheManger,
  }) : super(VideoLoading()) {
    on<SaleassistTileLoadEvent>(_loadVideos);
  }

  FutureOr<void> _loadVideos(
      SaleassistTileLoadEvent event, Emitter<SaleassistTileState> emit) async {
    emit(VideoLoading());
    try {
      APIResponse response =
          await tilesApiRepository.getVideoTiles(playlistId: event.playlistId);
      if (response is SuccessResponse) {
        ShortsModel shortsModel = ShortsModel.fromMap(response.rawData);
        final List<Future<dynamic>> futures = [];
        for (int i = 0; i < shortsModel.media!.length; i++) {
          String url = shortsModel.media![i].media!;
          if (await chacheManger.getFileFromCache(url) == null) {
            futures.add(chacheManger.uploadToCache(url));
            futures.add(chacheManger
                .uploadToCache(shortsModel.media![i].shortVideoUrl ?? url));
          }
        }
        await Future.wait(futures);
        final List<Future<FileInfo?>> shortsFuture = [];
        List<FileInfo?> shorts = [];

        for (int i = 0; i < shortsModel.media!.length; i++) {
          String url = shortsModel.media![i].media!;
          shortsFuture.add(chacheManger
              .getFileFromCache(shortsModel.media![i].shortVideoUrl ?? url));
        }
        shorts = await Future.wait(shortsFuture);
        emit(VideoLoadSuccess(fileInfos: shorts, shortsModel: shortsModel));
      } else {
        emit(VideoLoadFailure('Something went wrong'));
      }
    } catch (e) {
      emit(VideoLoadFailure(e.toString()));
    }
  }
}
