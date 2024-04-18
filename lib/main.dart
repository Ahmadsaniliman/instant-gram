import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Providers/Provids/is_loading_pro.dart';
import 'package:instantgram/Providers/Provids/is_logged_in_pro.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instant-g',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Consumer(
        builder: (context, ref, child) {
          ref.listen(isLoadingProvider, (previous, isLoading) {
            if (isLoading) {
              LoadingScreen.instance().show(
                context: context,
              );
            } else {
              LoadingScreen.instance().hide();
            }
          });
          final isLoaggedIn = ref.watch(isLoggedInProvider);
          if (isLoaggedIn) {
            return const MainScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
