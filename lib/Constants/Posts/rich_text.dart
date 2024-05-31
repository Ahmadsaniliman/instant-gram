import 'package:flutter/material.dart';

class RichTwoTextWidget extends StatelessWidget {
  final String leftPart;
  final String rightPart;
  const RichTwoTextWidget({
    super.key,
    required this.leftPart,
    required this.rightPart,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.white70,
        ),
        children: [
          TextSpan(
            text: rightPart,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: ' $leftPart',
          ),
        ],
      ),
    );
  }
}
