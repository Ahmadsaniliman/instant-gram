import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';

@immutable
class UserInfoPayLoad extends MapView<String, String> {
  UserInfoPayLoad({
required UserId userId,
required String? displayName,
required String? email,
  }) : super({
    FirebaseFieldNames.userId : userId,
    FirebaseFieldNames.displayName : displayName ?? '',
    FirebaseFieldNames.email : email ?? '',
  });
}
