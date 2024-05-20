import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/post_settings.dart';

class PostSettingNotifier extends StateNotifier<Map<PostSettings, bool>> {
  PostSettingNotifier()
      : super(
          UnmodifiableMapView(
            {
              for (final setting in PostSettings.values) setting: true,
            },
          ),
        );
  void setting(PostSettings setting, bool value) {
    final existingValue = state[setting];
    if (existingValue == null || existingValue == value) {
      return;
    }
    state = Map.unmodifiable(
      Map.from(state)..[setting] = value,
    );
  }
}

final postSettingsProvider = StateNotifierProvider<PostSettingNotifier, PostSettings>(
  (ref) => PostSettingNotifier(),
);
