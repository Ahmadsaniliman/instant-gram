import 'package:flutter/material.dart';

@immutable
class BaseText {
  final String text;
  final TextStyle style;

  const BaseText({
    required this.text,
    required this.style,
  });

  factory BaseText.plain({
    required String text,
    TextStyle style = const TextStyle(),
  }) =>
      BaseText(text: text, style: style);
}
