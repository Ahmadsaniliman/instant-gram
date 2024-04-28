import 'package:instantgram/Dialog/general_dialog.dart';
import 'package:instantgram/Widgets/Strings/strings.dart';

class LogOutDialog extends ALertDialogModel {
  LogOutDialog()
      : super(
          title: Strings.logOut,
          message: Strings.areYouSureYouWantToLogOutOfTheApplogOut,
          buttons: {
            Strings.cancel: false,
            Strings.logOut: true,
          },
        );
}
