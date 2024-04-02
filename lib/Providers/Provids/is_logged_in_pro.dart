import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Models/auth_result.dart';
import 'package:instantgram/Providers/Provids/auth_state_provider.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResults.success;
});
