import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/ImageUpLoad/thumbnail_provider.dart';
import 'package:instantgram/Constants/ImageUpLoad/thumbnail_request.dart';
import 'package:instantgram/LottieAnimations/error_anim_view.dart';
import 'package:instantgram/LottieAnimations/oading_anim_view.dart';

class FileThumbnailView extends ConsumerWidget {
  final ThumbnailRequest thumbnailRequest;
  const FileThumbnailView(this.thumbnailRequest, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(
      thumbnailProvider(thumbnailRequest),
    );
    return thumbnail.when(loading: () {
      return LoadingAnimationView(key: key);
    }, error: (Object error, StackTrace stackTrace) {
      return ErrorAnimationView(key: key);
    }, data: (data) {
      return AspectRatio(
        aspectRatio: data.ratio,
        child: data.image,
      );
    });
  }
}
