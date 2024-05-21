import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/Constants/ImageUpLoad/file_thumbnail_view.dart';
import 'package:instantgram/Constants/ImageUpLoad/image_upload_provider.dart';
import 'package:instantgram/Constants/ImageUpLoad/thumbnail_request.dart';
import 'package:instantgram/Constants/Posts/file_type.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:instantgram/Constants/Posts/post_setting_provider.dart';
import 'package:instantgram/Constants/Posts/post_settings.dart';
import 'package:instantgram/Providers/Provids/user_id_provider.dart';

class CreateNewPost extends StatefulHookConsumerWidget {
  final File file;
  final FileType fileType;
  const CreateNewPost({
    super.key,
    required this.file,
    required this.fileType,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateNewPostState();
}

class _CreateNewPostState extends ConsumerState<CreateNewPost> {
  @override
  Widget build(BuildContext context) {
    final thumbnailRequest = ThumbnailRequest(
      file: widget.file,
      fileType: widget.fileType,
    );

    final postSettingProvider = ref.watch(postSettingsProvider);
    final postController = useTextEditingController();
    final isButtonEnabled = useState(false);

    useEffect(() {
      void listener() {
        isButtonEnabled.value = postController.text.isNotEmpty;
      }

      postController.addListener(listener);

      return () {
        postController.removeListener(listener);
      };
    }, [postController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          IconButton(
            onPressed: isButtonEnabled.value
                ? () async {
                    final userId = ref.read(userIdProvider);
                    if (userId == null) {
                      return;
                    }

                    final message = postController.text;

                    final isUpLoad =
                        await ref.read(imageUpLoadProvider.notifier).upLoad(
                              userId: userId,
                              message: message,
                              file: widget.file,
                              fileType: widget.fileType,
                              postSettings: postSettingProvider,
                            );

                    if (isUpLoad && mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FileThumbnailView(thumbnailRequest: thumbnailRequest),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: postController,
                autofocus: true,
                maxLines: null,
                decoration:
                    const InputDecoration(labelText: 'Create new post here'),
              ),
            ),
            ...PostSettings.values.map(
              (postSetting) => ListTile(
                title: Text(postSetting.title),
                subtitle: Text(postSetting.description),
                trailing: Switch(
                  value: postSettingProvider[postSetting] ?? false,
                  onChanged: (isOn) {
                    ref.read(postSettingsProvider.notifier).setting(
                          postSetting,
                          isOn,
                        );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
