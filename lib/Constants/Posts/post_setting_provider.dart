import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/post_setting_notifier.dart';
import 'package:instantgram/Constants/Posts/post_settings.dart';

final postSettingsProvider =
    StateNotifierProvider<PostSettingNotifier, Map<PostSettings, bool>>(
  (ref) => PostSettingNotifier(),
);
