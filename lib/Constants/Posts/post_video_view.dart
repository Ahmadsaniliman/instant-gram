import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:instantgram/Constants/Posts/post.dart';
import 'package:instantgram/LottieAnimations/oading_anim_view.dart';
import 'package:video_player/video_player.dart';

class PostVideoView extends HookWidget {
  final Post post;
  const PostVideoView({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final controller = VideoPlayerController.networkUrl(
      Uri.parse(post.fileUrl),
    );

    final isPlayedVideo = useState(false);

    useEffect(
      () {
        controller.initialize().then(
          (value) {
            isPlayedVideo.value = true;
            controller.play();
          },
        );
        return controller.dispose;
      },
      [controller],
    );

    switch (isPlayedVideo.value) {
      case true:
        return AspectRatio(
          aspectRatio: post.aspectRatio,
          child: VideoPlayer(controller),
        );
      case false:
        return LoadingAnimationView(key: key);
    }
  }
}
