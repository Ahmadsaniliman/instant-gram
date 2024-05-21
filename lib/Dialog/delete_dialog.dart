import 'package:flutter/foundation.dart';
import 'package:instantgram/Dialog/general_dialog.dart';

@immutable
class DeleteDialog extends ALertDialogModel<bool> {
  DeleteDialog()
      : super(
          title: 'Delete Comment',
          message: 'Are you sure you want tot delete this comment',
          buttons: {
            'Cancel': false,
            'Dleete': true,
          },
        );
}
