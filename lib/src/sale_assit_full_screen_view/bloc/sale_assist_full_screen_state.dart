import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:saleassist_video_tiles/src/sale_assist_tiles/model/shorts_model/shorts_model.dart';

@immutable
abstract class SaleAssistFullScreenState extends Equatable {
  final ShortsModel? shortsModel;
  const SaleAssistFullScreenState({required this.shortsModel});
  @override
  List<Object?> get props => [shortsModel];
}

class SaleAssistFullScreenInitial extends SaleAssistFullScreenState {
  const SaleAssistFullScreenInitial({required super.shortsModel});
}

class SaleAssistFullScreenLoading extends SaleAssistFullScreenState {
  const SaleAssistFullScreenLoading({required super.shortsModel});
}

class SaleAssistFullScreenError extends SaleAssistFullScreenState {
  final String message;
  const SaleAssistFullScreenError(
      {required super.shortsModel, required this.message});
  @override
  List<Object?> get props => [message];
}

class SaleAssistFullScreenLoaded extends SaleAssistFullScreenState {
  final int currentIndex;
  final FileInfo current;
  final FileInfo? future;
  final FileInfo? previous;

  const SaleAssistFullScreenLoaded({
    required ShortsModel shortsModel,
    required this.currentIndex,
    this.future,
    required this.current,
    this.previous,
  }) : super(shortsModel: shortsModel);

  @override
  List<Object?> get props => [
        shortsModel,
        currentIndex,
        current,
        future,
        previous,
      ];
}
