import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_car_app/Homepage.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
String u;
Future<String> signInWithGoogle()async {
    await Firebase.initializeApp();

    final GoogleSignInAccount googleAcc = await googleSignIn.signIn();
    final GoogleSignInAuthentication authentication = await googleAcc.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);

    final User user = authResult.user;

    if(user != null){
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('---Sign in with google succeed $user');
      Homepage.user = user.displayName;
      return '$user';
    }
    return null;
}

Future<void> signOutGoogle() async {

  await _auth.signOut().then((_){
    googleSignIn.signOut();
  });

  print(FirebaseAuth.instance.currentUser.displayName);
  print('User signed out');
}