import 'package:flutter/foundation.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';
import 'package:instantgram/Models/auth_result.dart';

@immutable
class AuthState {
  final UserId? userId;
  final AuthResults? results;
  final bool? isLoading;

  const AuthState({
    required this.userId,
    required this.results,
    required this.isLoading,
  });

  const AuthState.unKnown()
      : results = null,
        userId = null,
        isLoading = false;

  AuthState copiedWith(bool isLoading) => AuthState(
        userId: userId,
        results: results,
        isLoading: isLoading,
      );

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (results == other.results &&
          isLoading == other.isLoading &&
          userId == other.userId);

  @override
  int get hashCode => Object.hash(
        results,
        userId,
        isLoading,
      );
}
