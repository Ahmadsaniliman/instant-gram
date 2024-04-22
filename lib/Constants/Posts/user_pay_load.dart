import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';

@immutable
class UserPayLoad extends MapView<String, dynamic> {
  UserPayLoad({
    required UserId? userId,
    required String? email,
    required String? displayName,
  }) : super({
          FirebaseFieldNames.userId: userId,
          FirebaseFieldNames.displayName: displayName ?? '',
          FirebaseFieldNames.email: email ?? '',
        });
}
