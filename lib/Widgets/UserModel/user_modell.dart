import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';

@immutable
class UserModel extends MapView<String, dynamic> {
  final UserId userId;

  final String displayName;
  final String? email;
  UserModel({
    required this.userId,
    required this.displayName,
    required this.email,
  }) : super(
          {
            FirebaseFieldNames.userId: userId,
            FirebaseFieldNames.displayName: displayName,
            FirebaseFieldNames.email: email,
          },
        );

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          displayName == other.displayName &&
          email == other.email;

  @override
  int get hashCode => Object.hashAll(
        [
          runtimeType,
        ],
      );

  UserModel.fromJson(
    Map<String, dynamic> json,
    UserId userId,
  ) : this(
          userId: userId,
          displayName: json[FirebaseFieldNames.displayName] as String,
          email: json[FirebaseFieldNames.email],
        );
}
