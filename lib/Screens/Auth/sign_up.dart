import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Providers/Provids/auth_state_provider.dart';
import 'package:instantgram/Utils/google_button.dart';
import 'package:instantgram/Widgets/Strings/strings.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.appName,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                Strings.welcomeToAppName,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Container(
                height: 2,
                width: double.infinity,
                color: Colors.white,
              ),
              Text(
                Strings.logInToYourAccount,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  ref.read(authStateProvider.notifier).logInWithgoogle();
                },
                style: TextButton.styleFrom(),
                child: const GoogleButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
