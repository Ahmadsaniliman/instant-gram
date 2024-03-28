import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';
import 'package:instantgram/Constants/constants.dart';
import 'package:instantgram/Models/auth_result.dart';

@immutable
class Authenticator {
  const Authenticator();
  UserId? get userId => FirebaseAuth.instance.currentUser!.uid;
  bool get isAlreadyLoggedIn => userId != null;
  String get displaName => FirebaseAuth.instance.currentUser!.displayName ?? '';
  String? get email => FirebaseAuth.instance.currentUser!.email;

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<AuthResults> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        Constants.emailScope,
      ],
    );

    final accountSignIn = await googleSignIn.signIn();

    if (accountSignIn == null) {
      return AuthResults.aborted;
    }

    final authSignIn = await accountSignIn.authentication;
    final authCredentials = GoogleAuthProvider.credential(
      idToken: authSignIn.idToken,
      accessToken: authSignIn.accessToken,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(
        authCredentials,
      );
      return AuthResults.success;
    } catch (e) {
      return AuthResults.failure;
    }
  }
}
