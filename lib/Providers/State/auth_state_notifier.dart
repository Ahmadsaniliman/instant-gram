import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';
import 'package:instantgram/Models/auth_result.dart';
import 'package:instantgram/Providers/State/auth_state.dart';
import 'package:instantgram/Providers/auth_provider.dart';
import 'package:instantgram/Storage/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _saveUserInfo = const SaveUserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unKnown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResults.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
    Future<void> logOut() async {
      state = state.copiedWith(true);
      await _authenticator.logOut();
      state = const AuthState.unKnown();
    }

    Future<void> logInWithGoogle() async {
      state = state.copiedWith(true);
      final result = await _authenticator.signInWithGoogle();
      final userId = _authenticator.userId;

      if (result == AuthResults.success && userId != null) {
        await saveUserInfo(userId: userId);
      }

      state = AuthState(
        result: result,
        isLoading: false,
        userId: userId,
      );
    }
  }

  Future<void> saveUserInfo({required UserId userId}) => _saveUserInfo.saveInfo(
        userId: userId,
        displayName: _authenticator.displaName,
        email: _authenticator.email,
      );
}
