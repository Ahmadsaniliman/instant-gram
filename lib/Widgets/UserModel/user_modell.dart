import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';

@immutable
class UserModel extends MapView<String, dynamic> {
  UserModel({
    required UserId userId,
    required String? email,
    required String displayName,
  }) : super(
          {
            FirebaseFieldNames.userId: userId,
            FirebaseFieldNames.displayName: displayName,
            FirebaseFieldNames.email: email,
          },
        );

  UserModel.fromJson(
    Map<String, dynamic> json, {
    required UserId userId,
  }) : this(
          userId: userId,
          displayName: json[FirebaseFieldNames.displayName] as String,
          email: json[FirebaseFieldNames.email],
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
          userId,
          email,
          displayName,
        ],
      );
}
