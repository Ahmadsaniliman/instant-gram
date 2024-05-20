import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/ImageUpLoad/image_uploader_notifier.dart';

final imageUpLoadProvider = StateNotifierProvider<ImageUpLoadNotifier, bool>(
  (ref) => ImageUpLoadNotifier(),
);
