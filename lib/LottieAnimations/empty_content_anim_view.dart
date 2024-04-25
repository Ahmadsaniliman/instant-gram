import 'package:flutter/material.dart';
import 'package:instantgram/LottieAnimations/empty_anim_view.dart';

class EmptyContentAnimationView extends StatelessWidget {
  final String text;
  const EmptyContentAnimationView({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(text),
          EmptyAnimationView(key: key),
        ],
      ),
    );
  }
}
