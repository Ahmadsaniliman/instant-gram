import 'package:flutter/material.dart';
import 'package:instantgram/Widgets/RichText/base_text.dart';
import 'package:instantgram/Widgets/RichText/rich_text.dart';
import 'package:instantgram/Widgets/Strings/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpLink extends StatelessWidget {
  const SignUpLink({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      styleForAll: Theme.of(context).textTheme.titleMedium?.copyWith(
            height: 1.5,
          ),
      text: [
        BaseText.plain(
          text: Strings.dontHaveAnAccount,
        ),
        BaseText.plain(
          text: Strings.signUpOn,
        ),
        BaseText.link(
          text: Strings.google,
          onTapped: () {
            launchUrl(
              Uri.parse(
                Strings.googleSignUpUrl,
              ),
            );
          },
        ),
      ],
    );
  }
}
