import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Providers/Provids/auth_state_provider.dart';

final userIdProvider = Provider((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.userId;
});
