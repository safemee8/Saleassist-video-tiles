import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saleassist_video_tiles/core/enums/video_tile_type.dart';
import 'package:saleassist_video_tiles/core/repository/tiles_api_repository.dart';
import 'package:saleassist_video_tiles/core/services/cache/chache_manger.dart';
import 'package:saleassist_video_tiles/src/sale_assist_tiles/views/tiles/saleassist_cover_flow_view.dart';
import 'package:saleassist_video_tiles/src/sale_assist_tiles/views/tiles/saleassist_story_view.dart';
import 'package:saleassist_video_tiles/src/sale_assist_tiles/bloc/saleassist_tile_view_bloc.dart';
import 'package:saleassist_video_tiles/src/sale_assist_tiles/views/tiles/saleassist_tile_view.dart';

import '../bloc/saleassist_tile_view_event.dart';

class SaleassistVideoTiles extends StatelessWidget {
  final VideoTileType type;
  final String playListId;
  final double? borderRadius;
  final bool autoPlay;
  final Size tileSize;
  final double? seperatorWidth;
  const SaleassistVideoTiles(
      {super.key,
      this.type = VideoTileType.tileView,
      required this.playListId,
      this.borderRadius,
      this.autoPlay = false,
      this.tileSize = const Size(100, 200),
      this.seperatorWidth});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SaleassistTileBloc>(
      create: (context) => SaleassistTileBloc(
          tilesApiRepository: TilesApiRepository(),
          chacheManger: SaleAssisstChacheManger())
        ..add(SaleassistTileLoadEvent(
          playlistId: playListId,
          videos: [
            "https://client-static.saleassist.ai/10b07b83-c8e3-4b74-8c06-3eb5923794af/TheShotThatFooled50MillionPeople-Mokum360ph264.mp4",
            "https://client-static.saleassist.ai/10b07b83-c8e3-4b74-8c06-3eb5923794af/TheShotThatFooled50MillionPeople-Mokum360ph264.mp4",
            "https://client-static.saleassist.ai/10b07b83-c8e3-4b74-8c06-3eb5923794af/TheShotThatFooled50MillionPeople-Mokum360ph264.mp4",
            "https://client-static.saleassist.ai/10b07b83-c8e3-4b74-8c06-3eb5923794af/TheShotThatFooled50MillionPeople-Mokum360ph264.mp4",
            "https://client-static.saleassist.ai/10b07b83-c8e3-4b74-8c06-3eb5923794af/TheShotThatFooled50MillionPeople-Mokum360ph264.mp4",
            "https://client-static.saleassist.ai/10b07b83-c8e3-4b74-8c06-3eb5923794af/TheShotThatFooled50MillionPeople-Mokum360ph264.mp4",
            "https://client-static.saleassist.ai/10b07b83-c8e3-4b74-8c06-3eb5923794af/TheShotThatFooled50MillionPeople-Mokum360ph264.mp4",
            "https://client-static.saleassist.ai/10b07b83-c8e3-4b74-8c06-3eb5923794af/TheShotThatFooled50MillionPeople-Mokum360ph264.mp4",
            "https://client-static.saleassist.ai/10b07b83-c8e3-4b74-8c06-3eb5923794af/TheShotThatFooled50MillionPeople-Mokum360ph264.mp4",
            "https://client-static.saleassist.ai/10b07b83-c8e3-4b74-8c06-3eb5923794af/TheShotThatFooled50MillionPeople-Mokum360ph264.mp4",
            "https://client-static.saleassist.ai/10b07b83-c8e3-4b74-8c06-3eb5923794af/TheShotThatFooled50MillionPeople-Mokum360ph264.mp4"
          ],
        )),
      child: Builder(
        builder: (context) {
          switch (type) {
            case VideoTileType.tileView:
              return SaleassistTileView(
                borderRadius: borderRadius,
                seperatorWidth: seperatorWidth,
                size: tileSize,
                autoPlay: autoPlay,
                playListId: playListId,
              );
            case VideoTileType.coverFlow:
              return const SaleassistCoverFlowView();
            case VideoTileType.story:
              return const SaleassistStoryView();
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
