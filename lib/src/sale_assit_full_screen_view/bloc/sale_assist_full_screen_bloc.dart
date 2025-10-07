import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:saleassist_video_tiles/core/services/cache/chache_manger.dart';
import 'package:saleassist_video_tiles/src/sale_assist_tiles/model/shorts_model/shorts_model.dart';
import 'package:saleassist_video_tiles/src/sale_assit_full_screen_view/bloc/sale_assist_full_screen_event.dart';
import 'package:saleassist_video_tiles/src/sale_assit_full_screen_view/bloc/sale_assist_full_screen_state.dart';

class SaleAssistFullScreenBloc
    extends Bloc<SaleAssistFullScreenEvent, SaleAssistFullScreenState> {
  SaleAssisstChacheManger saleAssisstChacheManger;
  SaleAssistFullScreenBloc({
    required this.saleAssisstChacheManger,
  }) : super(const SaleAssistFullScreenInitial(shortsModel: null)) {
    on<SaleAssistFullScreenChangePageEvent>(_pageChage);
    on<SaleAssistFullScreenInitEvent>(_initFullScreen);
  }

  FutureOr<void> _pageChage(
    SaleAssistFullScreenChangePageEvent event,
    Emitter<SaleAssistFullScreenState> emit,
  ) async {
    const errorMessage = "Something went wrong";

    ShortsModel shortsModel = state.shortsModel!;
    final mediaList = shortsModel.media!;

    emit(SaleAssistFullScreenLoading(shortsModel: shortsModel));

    try {
      final int index = event.pageIndex;

      // Prepare URLs
      final String currentUrl = mediaList[index].media!;
      // final String? nextUrl =
      //     (index + 1 < mediaList.length) ? mediaList[index + 1].media : null;
      // final String? prevUrl =
      //     (index - 1 >= 0) ? mediaList[index - 1].media : null;

      // Build futures in parallel
      final futures = <Future<FileInfo?>>[
        saleAssisstChacheManger.getFileFromCache(currentUrl),
        // if (nextUrl != null) saleAssisstChacheManger.getFileFromCache(nextUrl),
        // if (prevUrl != null) saleAssisstChacheManger.getFileFromCache(prevUrl),
      ];

      final results = await Future.wait(futures);

      final FileInfo? current = results[0];
      // final FileInfo? future = nextUrl != null ? results[1] : null;
      // final FileInfo? previous =
      //     prevUrl != null ? results[results.length - 1] : null;

      if (current == null) {
        emit(SaleAssistFullScreenError(
            shortsModel: shortsModel, message: errorMessage));
        return;
      }
      log("CURRENT URL : ${current.originalUrl} INDEX : $index");
      emit(
        SaleAssistFullScreenLoaded(
          shortsModel: shortsModel,
          currentIndex: index,
          current: current,
          // future: future,
          // previous: previous,
        ),
      );
    } catch (e) {
      emit(SaleAssistFullScreenError(
          shortsModel: shortsModel, message: errorMessage));
    }
  }

  FutureOr<void> _initFullScreen(
    SaleAssistFullScreenInitEvent event,
    Emitter<SaleAssistFullScreenState> emit,
  ) async {
    const errorMessage = "Something went wrong";

    final shortsModel = event.shortsModel;
    if (shortsModel == null || shortsModel.media == null) {
      emit(SaleAssistFullScreenError(
          shortsModel: shortsModel, message: errorMessage));
      return;
    }

    emit(SaleAssistFullScreenLoading(shortsModel: shortsModel));

    try {
      final mediaList = shortsModel.media!;
      final int index = event.index;

      // Prepare URLs
      final String currentUrl = mediaList[index].media!;
      // FUTURE
      final String? nextUrl =
          (index + 1 < mediaList.length) ? mediaList[index + 1].media : null;
      // PAST
      final String? prevUrl =
          (index - 1 >= 0) ? mediaList[index - 1].media : null;

      // Build futures in parallel
      final futures = <Future<FileInfo?>>[
        saleAssisstChacheManger.getFileFromCache(currentUrl),
        if (nextUrl != null) saleAssisstChacheManger.getFileFromCache(nextUrl),
        if (prevUrl != null) saleAssisstChacheManger.getFileFromCache(prevUrl),
      ];

      final results = await Future.wait(futures);

      final FileInfo? current = results[0];
      final FileInfo? future = nextUrl != null ? results[1] : null;
      final FileInfo? previous =
          prevUrl != null ? results[results.length - 1] : null;

      if (current == null) {
        emit(SaleAssistFullScreenError(
            shortsModel: shortsModel, message: errorMessage));
        return;
      }

      emit(
        SaleAssistFullScreenLoaded(
          shortsModel: shortsModel,
          currentIndex: index,
          current: current,
          future: future,
          previous: previous,
        ),
      );
    } catch (e) {
      emit(SaleAssistFullScreenError(
          shortsModel: shortsModel, message: errorMessage));
    }
  }
}
