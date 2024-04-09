import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instantgram/Widgets/Loading/loading_screen_controller.dart';
import 'package:instantgram/Widgets/Strings/strings.dart';

class LoadingScreen {
  LoadingScreen.instance();
  static final shared = LoadingScreen.instance();
  factory LoadingScreen() => shared;

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    String text = Strings.loading,
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = showOverlay(
        context: context,
        text: text,
      );
    }
  }

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

    final overLay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  minWidth: size.width * 0.5,
                  minHeight: size.height * 0.8,
                  maxWidth: size.width * 0.8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const CircularProgressIndicator(),
                    const SizedBox(height: 10),
                    StreamBuilder<String>(
                      stream: textController.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.requireData);
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    state.insert(overLay);
    return LoadingScreenController(update: (text) {
      textController.add(text);
      return true;
    }, close: () {
      textController.close();
      overLay.remove();
      return true;
    });
  }
}
