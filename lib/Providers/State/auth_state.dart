import 'package:flutter/foundation.dart' show immutable;
import 'package:instantgram/Constants/Posts/user_id.dart';
import 'package:instantgram/Models/auth_result.dart';

@immutable
class AuthState {
  final bool isLoading;
  final UserId? userId;
  final AuthResults? results;

  const AuthState({
    required this.isLoading,
    required this.userId,
    required this.results,
  });

  const AuthState.unKnown()
      : results = null,
        userId = null,
        isLoading = false;

  AuthState copiedWith(bool isLoading) => AuthState(
        isLoading: isLoading,
        userId: userId,
        results: results,
      );

  @override
  bool operator ==(covariant AuthState other) =>
      results == other.results ||
      isLoading == other.isLoading ||
      userId == other.userId;

  @override
  int get hashCode => Object.hash(
        results,
        isLoading,
        userId,
      );
}
