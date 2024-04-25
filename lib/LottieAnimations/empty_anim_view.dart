import 'package:instantgram/LottieAnimations/lotie_anim.dart';
import 'package:instantgram/LottieAnimations/lottie_anim_view.dart';

class EmptyAnimationView extends LottieAnimationView {
  const EmptyAnimationView({required super.key})
      : super(
          animation: LottieAnimation.empty,
        );
}
