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
  String? get displayName =>
      FirebaseAuth.instance.currentUser!.displayName ?? '';
  String? get email => FirebaseAuth.instance.currentUser!.email;

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<AuthResults> logInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        Constants.emailScope,
      ],
    );

    final accountSignIn = await googleSignIn.signIn();
    if (accountSignIn == null) {
      return AuthResults.aborted;
    }

    final googleAuth = await accountSignIn.authentication;
    final authCredentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(authCredentials);
      return AuthResults.success;
    } catch (e) {
      return AuthResults.failure;
    }
  }
}
