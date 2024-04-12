import 'package:flutter/material.dart';
import 'package:instantgram/Widgets/RichText/link_text.dart';

@immutable
class BaseText {
  final String text;
  final TextStyle? style;

  const BaseText({
    required this.text,
    required this.style,
  });

  factory BaseText.plain({
    required String text,
    TextStyle? style = const TextStyle(),
  }) =>
      BaseText(
        text: text,
        style: style,
      );

  factory BaseText.link({
    required String text,
    TextStyle? style = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
    required VoidCallback onTapped,
  }) =>
      LinkText(
        text: text,
        onTapped: onTapped,
        style: style,
      );
}
