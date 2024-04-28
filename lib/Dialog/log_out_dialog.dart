import 'package:flutter/foundation.dart' show immutable;
import 'package:instantgram/Dialog/general_dialog.dart';
import 'package:instantgram/Widgets/Strings/strings.dart';

@immutable
class LogOutDialog extends AlertDialogModel<bool> {
  LogOutDialog()
      : super(
          title: Strings.logOut,
          message: Strings.areYouSureYouWantToLogOutOfTheApplogOut,
          buttons: {
            Strings.logOut: true,
            Strings.cancel: false,
          },
        );
}
