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

  void setSetting(
    bool value,
    PostSettings setting,
  ) {
    final exsitingValue = state[setting];
    if (exsitingValue == null || exsitingValue == value) {
      return;
    }

    state = Map.unmodifiable(
      Map.from(
        state..[setting] = value,
      ),
    );
  }
}
