import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/youtube', // Youtube scope
  ],
);

Future<User> signIn() async {
  await Firebase.initializeApp();
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    idToken: googleSignInAuthentication.idToken,
    accessToken: googleSignInAuthentication.accessToken,
  );
  final token = googleSignInAuthentication.accessToken;
  print(token);
  // final AuthResult authResult = await auth.signInWithCredential(credential);
  // final User user = authResult.user;

  User user = (await auth.signInWithCredential(credential)).user;
  /*if (user != null) {
      name = user.displayName;
      email = user.email;
      imageUrl = user.photoURL;
    }*/
  //print(await getSubscriptions(token));

  return user;
}

Future<void> signOut() async {
  await googleSignIn.signOut();
  await auth.signOut();

  print("User Signed Out");
}
