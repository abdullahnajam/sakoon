import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  static  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn().onError((error, stackTrace){
      print("gauth error ${error.toString()}");
    });
    final GoogleSignInAuthentication googleAuth = await googleUser?.authentication;

    final credential =GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    /*await FacebookAuth.instance.login(permissions: ['email', 'public_profile']).then((value){
      print('fb success ${value.accessToken.token}');
    }).onError((error, stackTrace){
      print('fbbbbb error ${error.toString()}');
    });*/
    final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email', 'public_profile']);
    print('login status ${loginResult.status}');
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken.token);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}