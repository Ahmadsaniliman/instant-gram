import 'package:flutter/material.dart';

@immutable
class ALertDialogModel<T> {
  final String title;
  final String message;
  final Map<String, T> buttons;

  const ALertDialogModel({
    required this.title,
    required this.message,
    required this.buttons,
  });
}

extension Present<T> on ALertDialogModel<T> {
  Future<T?> present(BuildContext context) {
    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: buttons.entries
            .map(
              (entry) => TextButton(
                onPressed: () {
                  Navigator.of(context).pop(entry);
                },
                child: Text(entry.key),
              ),
            )
            .toList(),
      ),
    );
  }
}
