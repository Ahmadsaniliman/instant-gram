import 'package:flutter/foundation.dart' show immutable;

typedef UpdateLoadingScreen = bool Function(String text);
typedef CloseLoadingSCreen = bool Function();

@immutable
class LoadingScreenController {
  final UpdateLoadingScreen update;
  final CloseLoadingSCreen close;

  const LoadingScreenController({
    required this.update,
    required this.close,
  });
}
