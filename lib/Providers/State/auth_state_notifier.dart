import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';
import 'package:instantgram/Models/auth_result.dart';
import 'package:instantgram/Providers/State/auth_state.dart';
import 'package:instantgram/Providers/auth_provider.dart';
import 'package:instantgram/Storage/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _saveUserInfo = const SaveUserInfo();

  AuthStateNotifier() : super(const AuthState.unKnown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResults.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  Future<void> logOut() async {
    state = state.cpoiedWith(true);
    _authenticator.logOut();
    state = const AuthState.unKnown();
  }

  Future<void> saveUserInfo({required UserId userId}) =>
      _saveUserInfo.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
      );

  Future<void> logInWithgoogle() async {
    state = state.cpoiedWith(true);
    final result = await _authenticator.logInWithGoogle();
    final userId = _authenticator.userId;

    if (result == AuthResults.success && userId != null) {
      saveUserInfo(userId: userId);
      state = AuthState(
        result: result,
        isLoading: false,
        userId: userId,
      );
    }

    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.userId,
    );
  }
}
