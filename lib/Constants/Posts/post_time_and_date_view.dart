import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostDateAndTime extends StatelessWidget {
  final DateTime dateTime;
  const PostDateAndTime({
    super.key,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('d mm, yyyy, d:mm, a');
    return Text(
      formatter.format(dateTime),
    );
  }
}
