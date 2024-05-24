import 'dart:collection';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';

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

  UserModel.from(
    Map<String, dynamic> json,
    UserId userId,
  ) : this(
          userId: userId,
          displayName: json[FirebaseFieldNames.displayName] as String,
          email: json[FirebaseFieldNames.email],
        );
}
