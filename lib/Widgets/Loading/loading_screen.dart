import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instantgram/Widgets/Loading/loading_screen_controller.dart';
import 'package:instantgram/Widgets/Strings/strings.dart';

class LoadingScreen {
  LoadingScreen._instance();
  static final shared = LoadingScreen._instance();
  factory LoadingScreen() => shared;

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    String text = Strings.loading,
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = showOverLay(
        context: context,
        text: text,
      );
    }
  }

  void hide() {
    _controller?.close();
    _controller == null;
  }

  LoadingScreenController? showOverLay({
    required BuildContext context,
    required String text,
  }) {
    final textController = StreamController<String>();
    textController.add(text);

    final state = Overlay.of(context);
    // ignore: unnecessary_null_comparison
    if (state == null) {
      return null;
    }

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overLay = OverlayEntry(
      builder: (context) => Material(
        color: Colors.black.withAlpha(150),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: size.height * 0.8,
              maxWidth: size.height * 0.8,
              minWidth: size.width * 0.5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const CircularProgressIndicator(),
                    const SizedBox(height: 10),
                    StreamBuilder(
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
        ),
      ),
    );

    state.insert(overLay);
    LoadingScreenController(
      update: (text) {
        textController.add(text);
        return true;
      },
      close: () {
        textController.close();
        overLay.remove();
        return true;
      },
    );
  }
}
