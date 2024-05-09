import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/ImageUpLoad/image_with_aspect_ratio.dart';
import 'package:instantgram/Constants/ImageUpLoad/thumbnail_provider.dart';
import 'package:instantgram/Constants/ImageUpLoad/thumbnail_request.dart';
import 'package:instantgram/LottieAnimations/oading_anim_view.dart';
import 'package:instantgram/LottieAnimations/small_err_anim_view.dart';

class FileThumbnailView extends ConsumerWidget {
  final ThumbnailRequest thumbnailRequest;
  const FileThumbnailView({
    super.key,
    required this.thumbnailRequest,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(
      thumbnailProvider(
        thumbnailRequest,
      ),
    );
    return thumbnail.when(
      data: (ImageWIthAspectRatio data) {
        return AspectRatio(
          aspectRatio: data.aspectRatio,
          child: data.image,
        );
      },
      loading: () {
        return LoadingAnimationView(key: key);
      },
      error: (Object error, StackTrace stackTrace) {
        return SmallErrorAnimationView(key: key);
      },
    );
  }
}
