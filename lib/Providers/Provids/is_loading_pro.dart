import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/ImageUpLoad/image_upload_provider.dart';
import 'package:instantgram/Providers/Provids/auth_state_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final isUpLoading = ref.watch(imageUpLoadProvider);
  return authState.isLoading || isUpLoading;
});
