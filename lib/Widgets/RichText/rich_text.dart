import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instantgram/Widgets/RichText/base_text.dart';
import 'package:instantgram/Widgets/RichText/link_text.dart';

class RichTextWidget extends StatelessWidget {
  final Iterable<BaseText> text;
  final TextStyle? styleForAll;
  const RichTextWidget({
    super.key,
    required this.text,
    this.styleForAll,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: text.map(
          (baseText) {
            if (baseText is LinkText) {
              return TextSpan(
                text: baseText.text,
                style: styleForAll?.merge(baseText.style),
                recognizer: TapGestureRecognizer()..onTap = baseText.onTapped,
              );
            } else {
              return TextSpan(
                text: baseText.text,
                style: styleForAll?.merge(baseText.style),
              );
            }
          },
        ).toList(),
      ),
    );
  }
}
