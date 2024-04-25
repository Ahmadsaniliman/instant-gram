import 'package:flutter/material.dart';
import 'package:instantgram/LottieAnimations/lotie_anim.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationView extends StatelessWidget {
  final LottieAnimation animation;
  final bool repeat;
  final bool reverse;
  const LottieAnimationView({
    super.key,
    required this.animation,
    this.repeat = false,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      animation.fullPath,
      repeat: repeat,
      reverse: reverse,
    );
  }
}

extension GetFullPath on LottieAnimation {
  String get fullPath => 'assets/animation$name.json';
}
