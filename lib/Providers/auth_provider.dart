import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';
import 'package:instantgram/Constants/constants.dart';
import 'package:instantgram/Models/auth_result.dart';

class Auhtenticator {
  const Auhtenticator();

  UserId? get userId => FirebaseAuth.instance.currentUser!.uid;
  String? get email => FirebaseAuth.instance.currentUser!.email;
  bool get isAlreadyLoggedIn => userId != null;
  String get displaName => FirebaseAuth.instance.currentUser!.displayName ?? '';

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<AuthResults> logInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        Constants.emailScope,
      ],
    );

    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResults.failure;
    }

    final googleAuth = await signInAccount.authentication;
    final authCredentials = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(authCredentials);
      return AuthResults.success;
    } on SocketException catch (_) {
      return AuthResults.aborted;
    } catch (_) {
      return AuthResults.failure;
    }
  }

  Future<AuthResults> signInMethod(String email, String password) async {
    try {
      if (email.isEmpty && password.isEmpty) {
        // return 'error message';
      }
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResults.success;
    } catch (e) {
      return AuthResults.failure;
    }
  }
}
