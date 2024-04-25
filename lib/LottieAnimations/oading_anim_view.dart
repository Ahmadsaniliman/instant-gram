import 'package:instantgram/LottieAnimations/lotie_anim.dart';
import 'package:instantgram/LottieAnimations/lottie_anim_view.dart';

class LoadingAnimationView extends LottieAnimationView {
  const LoadingAnimationView({required super.key})
      : super(
          animation: LottieAnimation.loading,
        );
}
