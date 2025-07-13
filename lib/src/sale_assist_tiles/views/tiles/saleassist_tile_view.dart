import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saleassist_video_tiles/src/sale_assist_tiles/bloc/saeassist_tile_view_state.dart';
import 'package:saleassist_video_tiles/src/sale_assist_tiles/bloc/saleassist_tile_view_bloc.dart';
import 'package:saleassist_video_tiles/widgets/video_player.dart';
import 'package:video_player/video_player.dart';

class SaleassistTileView extends StatelessWidget {
  final double? seperatorWidth;
  final double? borderRadius;
  final Size size;
  final bool autoPlay;
  final String playListId;
  final double? iconSize;

  const SaleassistTileView({
    Key? key,
    this.seperatorWidth = 8.0,
    this.borderRadius = 12.0,
    required this.size,
    required this.autoPlay,
    required this.playListId,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaleassistTileBloc, SaleassistTileState>(
      builder: (context, state) {
        if (state is VideoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is VideoLoadFailure) {
          return Center(
            child: Text('Error loading videos: ${state.error}'),
          );
        } else if (state is VideoLoadSuccess) {
          return SizedBox(
            height: size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              itemCount: state.shortsModel.media!.length,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              cacheExtent: MediaQuery.of(context).size.width * 2,
              separatorBuilder: (context, index) =>
                  SizedBox(width: seperatorWidth),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              itemBuilder: (context, index) {
                return SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Center(
                    child: RepaintBoundary(
                      child: VideoTileWidget(
                        shortsModel: state.shortsModel,
                        fileInfo: state.fileInfos[index]!,
                        size: size,
                        iconSize: iconSize,
                        autoPlay: index == 0 ? autoPlay : false,
                        borderRadius: borderRadius,
                        key: Key(index.toString()),
                        index: index,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
