typedef UpdateLoadingScreen = bool Function(String text);
typedef CloseLoadingScreen = bool Function();

class LoadingScreenController {
  final UpdateLoadingScreen update;
  final CloseLoadingScreen close;

  LoadingScreenController({
    required this.update,
    required this.close,
  });
}
