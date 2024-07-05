import 'dart:async';

import 'package:flutter/material.dart';
import 'package:statemanager/page/loading/loading_screen_controller.dart';

class LoadingScreen {
  LoadingScreen._singleton();
  static LoadingScreen? _instance;
  factory LoadingScreen() {
    _instance ??= LoadingScreen._singleton();
    return _instance!;
  }

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    required String text,
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    }
    else {
      _controller = _showOverlay(context: context, text: text);
    }
  }

  void hide(){
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController _showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final _text = StreamController<String>();
    _text.add(text);
    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final overlay = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          height: size.height,
          child: Material(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: size.width * 0.8, maxHeight: size.height * 0.8, minWidth: size.width * 0.5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const CircularProgressIndicator(),
                        const SizedBox(
                          height: 20,
                        ),
                        StreamBuilder<String>(
                          stream: _text.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!,
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return const SizedBox();
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
      },
    );

    state.insert(overlay);
    _controller = LoadingScreenController(
      close: () {
        _text.close();
        overlay.remove();
        return true;
      },
      update: (text) {
        _text.add(text);
        return true;
      },
    );
    return _controller!;
  }
}
