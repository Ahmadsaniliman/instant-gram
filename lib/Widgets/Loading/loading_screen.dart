import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instantgram/Widgets/Loading/loading_screen_controller.dart';
import 'package:instantgram/Widgets/Strings/strings.dart';

class LoadingScreen {
  LoadingScreen._instance();
  static final shared = LoadingScreen._instance();
  factory LoadingScreen.instance() => shared;

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    String text = Strings.loading,
  }) {}

  void hide() {
    _controller?.close();
    _controller == null;
  }

  LoadingScreenController? showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final state = Overlay.of(context);
    // ignore: unnecessary_null_comparison
    if (state == null) {
      return null;
    }

    final textController = StreamController<String>();
    textController.add(text);

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
  }
}
