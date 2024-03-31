import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';
import 'package:instantgram/Models/auth_result.dart';
import 'package:instantgram/Providers/State/auth_state.dart';
import 'package:instantgram/Providers/auth_provider.dart';
import 'package:instantgram/Storage/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _saveUserInfo = const UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unKnown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        userId: _authenticator.userId,
        results: AuthResults.success,
        isLoading: false,
      );
    }

    Future<void> logOut() async {
      state = state.copiedWith(true);
      await _authenticator.logOut();
      state = const AuthState.unKnown();
    }

    Future<void> userInfo({required UserId userId}) =>
        _saveUserInfo.saveUserInfo(
          userId: userId,
          displayName: _authenticator.displaName,
          email: _authenticator.email,
        );

    Future<void> loginWithGoogle() async {
      state = state.copiedWith(true);
      final result = await _authenticator.signInWithGoogle();
      final userId = _authenticator.userId;

      if (result == AuthResults.success && userId != null) {
        await userInfo(userId: userId);
        AuthState(
          userId: userId,
          results: result,
          isLoading: false,
        );
      }
    }
  }
}
