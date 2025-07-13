import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saleassist_video_tiles/src/sale_assist_tiles/model/shorts_model/shorts_model.dart';
import 'package:saleassist_video_tiles/src/sale_assit_full_screen_view/bloc/sale_assist_full_screen_bloc.dart';
import 'package:saleassist_video_tiles/src/sale_assit_full_screen_view/bloc/sale_assist_full_screen_event.dart';
import 'package:saleassist_video_tiles/src/sale_assit_full_screen_view/bloc/sale_assist_full_screen_state.dart';
import 'package:saleassist_video_tiles/src/sale_assit_full_screen_view/view/full_screen_player.dart';
import 'package:video_player/video_player.dart';

class SaleAssistFullScreenPage extends StatefulWidget {
  final ShortsModel shortsModel;
  final int initialPage;

  const SaleAssistFullScreenPage({
    super.key,
    required this.shortsModel,
    this.initialPage = 0,
  });

  @override
  State<SaleAssistFullScreenPage> createState() =>
      _SaleAssistFullScreenPageState();
}

class _SaleAssistFullScreenPageState extends State<SaleAssistFullScreenPage> {
  late final PageController _pageCtrl;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialPage;
    _pageCtrl = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onPageChanged(int index) {
    log("message : Page changed to $index");
    context
        .read<SaleAssistFullScreenBloc>()
        .add(SaleAssistFullScreenChangePageEvent(pageIndex: index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageCtrl,
        scrollDirection: Axis.vertical,
        itemCount: widget.shortsModel.media!.length,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) {
          return BlocBuilder<SaleAssistFullScreenBloc,
              SaleAssistFullScreenState>(
            builder: (ctx, state) {
              if (state is SaleAssistFullScreenLoading) {
                // return const Center(child: CircularProgressIndicator());
                return Container();
              }
              if (state is SaleAssistFullScreenError) {
                return Center(
                  child: Text(
                    state.message ?? 'Error',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              if (state is SaleAssistFullScreenLoaded) {
                return FullScreenPlayer(
                  shortsModel: widget.shortsModel,
                  fileInfo: state.current,
                  index: state.currentIndex,
                );
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
