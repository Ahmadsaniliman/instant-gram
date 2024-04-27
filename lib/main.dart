import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Providers/Provids/is_loading_pro.dart';
import 'package:instantgram/Screens/Auth/sign_up.dart';
import 'package:instantgram/Screens/Main/main.dart';
import 'package:instantgram/Widgets/Loading/loading_screen.dart';
import 'package:instantgram/firebase_options.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Instant-g',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            ref.listen(isLoadingProvider, (_, isLoading) {
              if (isLoading) {
                LoadingScreen.instance().show(
                  context: context,
                );
              } else {
                LoadingScreen.instance().hide();
              }
            });
            final isLoaggedIn = ref.watch(isLoadingProvider);
            if (isLoaggedIn) {
              return const MainView();
            } else {
              return const SignInScreen();
            }
          },
          child: const SignInScreen(),
        ),
      ),
    );
  }
}
