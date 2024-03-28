import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Models/auth_result.dart';
import 'package:instantgram/Providers/State/auth_state.dart';
import 'package:instantgram/Providers/auth_provider.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();

  AuthStateNotifier() : super(const AuthState.unKnown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      AuthState(
        result: AuthResults.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
    Future<void> logOut() async {
      state = state.copiedWith(true);
      await _authenticator.logOut();
      const AuthState.unKnown();
    }

    Future<void> logInWithGoogle() async {
      state = state.copiedWith(true);
      final result = await _authenticator.signInWithGoogle();
      final userId = await _authenticator.userId;
      if (result == AuthResults.success && userId != null) {}
    }
  }
}
