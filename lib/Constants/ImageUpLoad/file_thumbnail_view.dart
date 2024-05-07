import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/ImageUpLoad/thumbnail_provider.dart';
import 'package:instantgram/Constants/ImageUpLoad/thumbnail_request.dart';
import 'package:instantgram/LottieAnimations/oading_anim_view.dart';
import 'package:instantgram/LottieAnimations/small_err_anim_view.dart';

class FileThumbnailView extends ConsumerWidget {
  const FileThumbnailView({
    required this.thumbnailRequest,
    super.key,
  });
  final ThumbnailRequest thumbnailRequest;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(
      thumbnailProvider(thumbnailRequest),
    );
    return thumbnail.when(data: (data) {
      return AspectRatio(
        aspectRatio: data.aspectRatio,
        child: data.image,
      );
    }, error: (error, stackTrace) {
      return SmallErrorAnimationView(key: key);
    }, loading: () {
      return LoadingAnimationView(key: key);
    });
  }
}
