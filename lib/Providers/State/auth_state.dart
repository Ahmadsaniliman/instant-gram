import 'package:flutter/foundation.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';
import 'package:instantgram/Models/auth_result.dart';

@immutable
class AuthState {
  final AuthResults? result;
  final bool isLoading;
  final UserId? userId;

  const AuthState({
    required this.result,
    required this.isLoading,
    required this.userId,
  });

  const AuthState.unKnown()
      : result = null,
        isLoading = false,
        userId = null;

  AuthState cpoiedWith(bool isLoading) => AuthState(
        result: result,
        isLoading: isLoading,
        userId: userId,
      );

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (result == other.result &&
          isLoading == other.isLoading &&
          userId == other.userId);

  @override
  int get hashCode => Object.hash(
        result,
        isLoading,
        userId,
      );
}
