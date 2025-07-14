import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:saleassist_video_tiles/core/extensions/string_extention.dart';
import 'package:saleassist_video_tiles/src/sale_assist_tiles/model/shorts_model/shorts_model.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlayer extends StatefulWidget {
  final FileInfo fileInfo;
  final ShortsModel shortsModel;
  final int index;
  final Function(String productId) onProductClick;

  const FullScreenPlayer({
    super.key,
    required this.fileInfo,
    required this.shortsModel,
    required this.index,
    required this.onProductClick,
  });

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late final VideoPlayerController _controller;
  bool _showUI = false;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _initializeController(widget.fileInfo);
  }

  @override
  void didUpdateWidget(covariant FullScreenPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if the file path has changed, dispose & re-init
    if (oldWidget.fileInfo.file.path != widget.fileInfo.file.path) {
      _controller.pause();
      _controller.dispose();
      _initializeController(widget.fileInfo);
    }
  }

  void _initializeController(FileInfo fileInfo) {
    _controller = VideoPlayerController.file(fileInfo.file)
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {/* rebuild with new controller */});
        _controller.play();
      });
  }

  void _toggleUI() {
    setState(() => _showUI = !_showUI);
    if (_showUI) {
      _hideTimer?.cancel();
      _hideTimer = Timer(const Duration(seconds: 4), () {
        if (mounted) setState(() => _showUI = false);
      });
    }
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          !_controller.value.isInitialized
              ? Center(child: Container())
              : VideoPlayer(_controller),
          GestureDetector(onTap: _toggleUI),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.18,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final product =
                      widget.shortsModel.media![widget.index].products![index];
                  return Container(
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        spacing: 8,
                        children: [
                          SizedBox(
                            height: (MediaQuery.of(context).size.height) - 16,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Container(
                              child: CarouselSlider.builder(
                                itemCount: product.productImages?.length ?? 0,
                                itemBuilder: (context, index, realIndex) {
                                  final url = product.productImages![index];
                                  return Image.network(
                                    url,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                  );
                                },
                                options: CarouselOptions(
                                  autoPlay: true,
                                  height: MediaQuery.of(context).size.height,
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: true,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 2,
                            children: [
                              Text(
                                product.productName ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                product.productCtaText ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              if (product.offerPrice != null)
                                Row(
                                  spacing: 8,
                                  children: [
                                    Text(
                                      "₹ ${(product.productPrice ?? 0).toStringAsFixed(1)}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    Text(
                                      "₹ ${(product.offerPrice ?? 0).toStringAsFixed(1)}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  widget.onProductClick(product.id ?? "");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: widget
                                              .shortsModel.themeColor !=
                                          null
                                      ? widget.shortsModel.themeColor!.toColor()
                                      : Theme.of(context).colorScheme.onPrimary,
                                  minimumSize: const Size.fromHeight(38),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  textStyle: TextStyle(color: Colors.white),
                                ),
                                child: Text(
                                  widget.shortsModel.media![widget.index]
                                          .ctaText ??
                                      "",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 8,
                  );
                },
                itemCount:
                    widget.shortsModel.media![widget.index].products!.length,
                shrinkWrap: true,
              ),
            ),
          ),
          if (_showUI)
            Center(
              child: IconButton(
                iconSize: 30,
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
              ),
            ),
          if (_showUI)
            Positioned(
              top: 24,
              right: 24,
              child: IconButton(
                iconSize: 30,
                color: Colors.white,
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _controller.value.volume > 0
                        ? Icons.volume_up
                        : Icons.volume_off,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _controller.setVolume(_controller.value.volume > 0 ? 0 : 1);
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
