import 'dart:io';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/Constants/ImageUpLoad/image_upload_provider.dart';
import 'package:instantgram/Constants/ImageUpLoad/thumbnail_request.dart';
import 'package:instantgram/Constants/Posts/file_type.dart';
import 'package:instantgram/Constants/Posts/post_setting_notifier.dart';
import 'package:instantgram/Providers/Provids/user_id_provider.dart';

class CreatPost extends StatefulHookConsumerWidget {
  final File fileToPost;
  final FileType fileType;
  const CreatPost({
    super.key,
    required this.fileToPost,
    required this.fileType,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreatPostState();
}

class _CreatPostState extends ConsumerState<CreatPost> {
  @override
  Widget build(BuildContext context) {
    final thumbnailequest = ThumbnailRequest(
      file: widget.fileToPost,
      fileType: widget.fileType,
    );

      final postSettings = ref.watch(postSettingsProvider);
    final postController = useTextEditingController();
    final isButtonEnabled = useState(false);

    useEffect(
      () {
        void listener() {
          isButtonEnabled.value = postController.text.isNotEmpty;
        }

        postController.addListener(listener);
        return () {
          postController.removeListener(listener);
        };
      },
      [postController],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Post'),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: isButtonEnabled.value
                ? () async {
                    final userId = ref.watch(userIdProvider);

                    if (userId == null) {
                      return;
                    }

                    final message = postController.text;
                    final isUpLoad =
                        await ref.read(imageUpLoadProvider.notifier).upLoad(
                              userId: userId,
                              message: message,
                              file: widget.fileToPost,
                              fileType: widget.fileType,
                              postSettings: postSettings,
                            );
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
