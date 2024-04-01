import 'package:flutter/foundation.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';
import 'package:instantgram/Models/auth_result.dart';

@immutable
class AuthState {
  final AuthResults? result;
  final UserId? userId;
  final bool isLoading;

  const AuthState({
    required this.result,
    required this.userId,
    required this.isLoading,
  });

  const AuthState.unKnown()
      : result = null,
        isLoading = false,
        userId = null;

  AuthState copiedWith(bool isLoading) => AuthState(
        result: result,
        userId: userId,
        isLoading: isLoading,
      );

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (result == other.result &&
          isLoading == other.isLoading &&
          userId == other.userId);

  @override
  int get hashCode => Object.hash(
        isLoading,
        userId,
        result,
      );
}
