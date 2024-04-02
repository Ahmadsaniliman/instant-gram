import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Providers/State/auth_state.dart';
import 'package:instantgram/Providers/State/auth_state_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(),
);
