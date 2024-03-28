import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';

@immutable
class UserInfoPayLoad extends MapView<String, String> {
  UserInfoPayLoad({
    required UserId userId,
    required String? displaName,
    required String? email,
  }) : super({
          FirebaseFieldNames.userId: userId,
          FirebaseFieldNames.displaName: displaName ?? '',
          FirebaseFieldNames.email: email ?? '',
        });
}
