import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/src/result/file_info.dart';
import 'package:saleassist_video_tiles/core/services/cache/chache_manger.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../src/sale_assist_tiles/model/shorts_model/shorts_model.dart';
import '../src/sale_assit_full_screen_view/bloc/sale_assist_full_screen_bloc.dart';
import '../src/sale_assit_full_screen_view/bloc/sale_assist_full_screen_event.dart';
import '../src/sale_assit_full_screen_view/view/sale_assist_full_screen.dart';

class VideoTileWidget extends StatefulWidget {
  final int index;
  final ShortsModel shortsModel;
  final double? iconSize;
  final Size size;
  final bool autoPlay;
  final FileInfo fileInfo;
  final double? borderRadius;
  const VideoTileWidget({
    Key? key,
    required this.index,
    required this.size,
    this.iconSize = 30.0,
    required this.shortsModel,
    this.autoPlay = false,
    this.borderRadius,
    required this.fileInfo,
  }) : super(key: key);

  @override
  _VideoTileWidgetState createState() => _VideoTileWidgetState();
}

class _VideoTileWidgetState extends State<VideoTileWidget> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() async {
    _controller = VideoPlayerController.file(widget.fileInfo.file);
    await _controller.initialize();
    if (mounted) {
      setState(() {
        _initialized = true;
      });
    }
    _controller.setLooping(true);
    _controller.setVolume(0);
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: widget.size.width,
        minHeight: widget.size.height,
        maxWidth: widget.size.width,
        maxHeight: widget.size.height,
      ),
      child: Stack(alignment: Alignment.center, children: [
        if (_initialized)
          Container(
            constraints: BoxConstraints(
              minWidth: widget.size.width,
              minHeight: widget.size.height,
              maxWidth: widget.size.width,
              maxHeight: widget.size.height,
            ),
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius ?? 0)),
                child: VideoPlayer(_controller)),
          )
        else
          const Center(child: CircularProgressIndicator()),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final isPlaying = _controller.value.isPlaying;
            return IconButton(
              iconSize: widget.iconSize,
              icon: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
              onPressed: _initialized
                  ? () {
                      isPlaying ? _controller.pause() : _controller.play();
                    }
                  : null,
            );
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: Positioned(
            top: 20,
            child: Column(
              spacing: 2,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final isMuted = _controller.value.volume == 0;
                    return IconButton(
                      iconSize: widget.iconSize,
                      icon: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isMuted ? Icons.volume_off : Icons.volume_up,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: _initialized
                          ? () {
                              if (isMuted) {
                                _controller.setVolume(1);
                                _controller.play();
                              } else {
                                _controller.setVolume(0);
                              }
                            }
                          : null,
                    );
                  },
                ),
                IconButton(
                  onPressed: () async {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        barrierColor: Colors.black,
                        transitionDuration: const Duration(milliseconds: 250),
                        pageBuilder: (_, __, ___) => BlocProvider(
                          create: (context) => SaleAssistFullScreenBloc(
                              saleAssisstChacheManger:
                                  SaleAssisstChacheManger())
                            ..add(
                              SaleAssistFullScreenInitEvent(
                                shortsModel: widget.shortsModel,
                                index: widget.index,
                              ),
                            ),
                          child: SaleAssistFullScreenPage(
                            initialPage: widget.index,
                            shortsModel: widget.shortsModel,
                          ),
                        ),
                        transitionsBuilder: (_, anim, __, child) =>
                            FadeTransition(opacity: anim, child: child),
                      ),
                    );
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.fullscreen_sharp,
                      color: Colors.white,
                      size: widget.iconSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if ((widget.shortsModel.media![widget.index].products ?? []).isNotEmpty)
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      barrierColor: Colors.black,
                      transitionDuration: const Duration(milliseconds: 250),
                      pageBuilder: (_, __, ___) => BlocProvider(
                        create: (context) => SaleAssistFullScreenBloc(
                            saleAssisstChacheManger: SaleAssisstChacheManger())
                          ..add(
                            SaleAssistFullScreenInitEvent(
                              shortsModel: widget.shortsModel,
                              index: widget.index,
                            ),
                          ),
                        child: SaleAssistFullScreenPage(
                          initialPage: widget.index,
                          shortsModel: widget.shortsModel,
                        ),
                      ),
                      transitionsBuilder: (_, anim, __, child) =>
                          FadeTransition(opacity: anim, child: child),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                        size: widget.iconSize,
                      ),
                      Text(
                        "${widget.shortsModel.media![widget.index].products!.length.toString()} Products",
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
      ]),
    );
  }
}
