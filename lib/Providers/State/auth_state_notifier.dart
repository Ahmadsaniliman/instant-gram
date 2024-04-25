import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';
import 'package:instantgram/Models/auth_result.dart';
import 'package:instantgram/Providers/State/auth_state.dart';
import 'package:instantgram/Providers/auth_provider.dart';
import 'package:instantgram/Storage/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final authenticator = const Auhtenticator();
  final userInfo = const UserInfoStorage();

  AuthStateNotifier()
      : super(
          const AuthState.unKnown(),
        ) {
    if (authenticator.isAlreadyLoggedIn) {
      AuthState(
        isLoading: false,
        userId: authenticator.userId,
        results: AuthResults.success,
      );
    }
  }

  Future<void> logOut() async {
    state = state.copiedWith(true);
    await authenticator.logOut();
    state = const AuthState.unKnown();
  }

  Future<void> saveUserInfo({required UserId userId}) => userInfo.saveUserInfo(
        userId: userId,
        displayName: authenticator.displaName,
        email: authenticator.email!,
      );
  Future<void> logInWithGoogle() async {
    state = state.copiedWith(true);
    final userId = authenticator.userId;
    final result = await authenticator.logInWithGoogle();
    if (result == AuthResults.success && userId != null) {
      await saveUserInfo(
        userId: userId,
      );

      state = AuthState(
        isLoading: false,
        userId: userId,
        results: result,
      );
    }
  }
}
