import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:sakoon/auth_service.dart';

class AuthBlock{
  final authService=AuthService();
  final fb=FacebookLogin();
  Stream<FirebaseUser> get currentUser => authService.currentUser;
  loginWithFacebook() async {
    print("starting facebook login");
    final res= await fb.logIn(
      permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,

      ]
    );
    switch(res.status){
      case FacebookLoginStatus.Success:
        print("SUCCESSFULLY LOGGED IN");
        final FacebookAccessToken fbtoken=res.accessToken;
        final AuthCredential credential=FacebookAuthProvider.getCredential(accessToken: fbtoken.token);
        final result= await authService.singInWithCredential(credential);
        print('${result.user.displayName} is not logged in');
        break;
      case FacebookLoginStatus.Cancel:
        print("THE USER CANCEL THE LOGIN");
        break;
      case FacebookLoginStatus.Error:
        print("SORRY THERE WAS AN ERROR");
        break;
    }

  }
}