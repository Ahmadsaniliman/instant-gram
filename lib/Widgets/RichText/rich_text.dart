import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instantgram/Widgets/RichText/base_text.dart';
import 'package:instantgram/Widgets/RichText/link_text.dart';
import 'package:instantgram/Widgets/Strings/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class RichTextWidget extends StatelessWidget {
  final Iterable<BaseText> texts;
  final TextStyle? stylesForAll;

  const RichTextWidget({
    super.key,
    required this.texts,
    this.stylesForAll,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: texts.map((baseText) {
          if (baseText is LinkText) {
            return TextSpan(
              text: baseText.text,
              style: stylesForAll!.merge(
                baseText.style,
              ),
              recognizer: TapGestureRecognizer()..onTap = baseText.onTapped,
            );
          } else {
            return TextSpan(
              text: baseText.text,
              style: stylesForAll!.merge(
                baseText.style,
              ),
            );
          }
        }).toList(),
      ),
    );
  }
}

class SingUpLogInLink extends StatelessWidget {
  const SingUpLogInLink({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      stylesForAll: Theme.of(context).textTheme.titleMedium?.copyWith(
            height: 1.5,
          ),
      texts: [
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
              Uri.parse(Strings.googleSignUpUrl),
            );
          },
        ),
        BaseText.plain(
          text: Strings.orCreateAnAccountOn,
        ),
      ],
    );
  }
}
