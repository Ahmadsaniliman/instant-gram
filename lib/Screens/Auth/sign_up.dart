import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Providers/Provids/auth_state_provider.dart';
import 'package:instantgram/Utils/google_button.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        child: Column(
          children: [
            const Text('Log Into Your Account'),
            TextButton(
              onPressed: () =>
                  ref.read(authStateProvider.notifier).logInWithGoogle(),
              child: const GoogleButton(),
            ),
          ],
        ),
      ),
    );
  }
}
