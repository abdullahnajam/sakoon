import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sakoon/components/no_account_text.dart';
import 'package:sakoon/components/socal_card.dart';
import 'package:sakoon/screens/complete_profile/complete_profile_screen.dart';
import 'package:sakoon/screens/home/homePage.dart';
import '../../../data/size_config.dart';
import 'sign_form.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}
class _BodyState extends State<Body> {
  getUserData() async{
    print("func");
    User user= FirebaseAuth.instance.currentUser;
    final userReference = FirebaseDatabase.instance.reference();
    await userReference.child("user").child(user.uid).once().then((DataSnapshot dataSnapshot){
      if(dataSnapshot.value == null){
        print("complete");
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CompleteProfileScreen()));
      }
      else{
        print("home");
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      }
    });
  }
  String name,image;
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  String _message = 'Log in/out by pressing the buttons below.';
  Future<Null> _login() async {
    final FacebookLoginResult result =
    await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }
  Future<User> signInWithFacebook() async {
    print("here");
    // Trigger the sign-in flow
    final FirebaseAuth _fAuth = FirebaseAuth.instance;
    final FacebookLoginResult facebookLoginResult = await facebookSignIn.logIn(['email']);
    FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
    AuthCredential authCredential = FacebookAuthProvider.credential(facebookAccessToken.token);//accessToken: facebookAccessToken.token);
    User fbUser;
    fbUser = (await _fAuth.signInWithCredential(authCredential)).user;
    //Token: ${accessToken.token}
  }


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser user;

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final User user = (await _auth.signInWithCredential(credential)).user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final User currentUser = await _auth.currentUser;
    assert(user.uid == currentUser.uid);
    print(user.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async{
    await googleSignIn.signOut();

    print("User Sign Out");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Row(
            children: [
              Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),)
            ],
          ),
          margin: EdgeInsets.only(top: 50,left: 20),
        ),
        Container(

          margin: EdgeInsets.only(top: 120),
          height: double.maxFinite,
          decoration: BoxDecoration(
              color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25)
            )
          ),
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Welcome",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in with your email and password",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SocalCard(
                      icon: "assets/images/google.png",
                      press: () {
                        signInWithGoogle().whenComplete(() {
                          FirebaseAuth.instance.authStateChanges().listen((User user) {
                            if (user == null) {
                              print('User is currently signed out!');
                            } else {
                              print("else");
                              getUserData();
                              /*Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));*/
                            }
                          });
                        }).catchError((onError){
                          print(onError.toString());
                        });
                      },
                    ),
                    SocalCard(
                      icon: "assets/images/facebook.png",
                      press:() {
                        signInWithFacebook().whenComplete(() {
                          FirebaseAuth.instance.authStateChanges().listen((User user) {
                            if (user == null) {
                              print('User is currently signed out!');
                            } else {
                              print("else");
                              getUserData();
                              /*Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));*/
                            }
                          });
                        }).catchError((onError){
                          print(onError.toString());
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                SignForm(),

                SizedBox(height: getProportionateScreenHeight(20)),
                NoAccountText(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

