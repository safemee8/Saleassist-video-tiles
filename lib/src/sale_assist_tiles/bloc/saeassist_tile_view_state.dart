import 'package:equatable/equatable.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:saleassist_video_tiles/src/sale_assist_tiles/model/shorts_model/shorts_model.dart';

abstract class SaleassistTileState extends Equatable {}

class VideoLoading extends SaleassistTileState {
  @override
  List<Object?> get props => [];
}

class VideoLoadSuccess extends SaleassistTileState {
  final List<FileInfo?> fileInfos;
  final ShortsModel shortsModel;
  VideoLoadSuccess({required this.fileInfos, required this.shortsModel});

  @override
  List<Object?> get props => [fileInfos, shortsModel];
}

class VideoLoadFailure extends SaleassistTileState {
  final String error;
  VideoLoadFailure(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
