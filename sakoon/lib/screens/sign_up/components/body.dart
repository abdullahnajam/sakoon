import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakoon/components/socal_card.dart';
import 'package:sakoon/data/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sakoon/data/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sakoon/screens/complete_profile/complete_profile_screen.dart';
import 'package:sakoon/screens/home/homePage.dart';
import 'package:sakoon/screens/sign_in/sign_in_screen.dart';
import '../../../api/auth_service.dart';
import '../../../dailogs/custom_alert_dialogs.dart';
import 'sign_up_form.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User googleUser;
  getUserData() async{
    final ref = FirebaseDatabase.instance.ref('user/${ FirebaseAuth.instance.currentUser.uid}');
    DatabaseEvent event = await ref.once();

    if (event.snapshot.value!=null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));

    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => CompleteProfileScreen()));
    }

  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Row(
            children: [
              Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),)
            ],
          ),
          margin: EdgeInsets.only(top: 50,left: 20),
        ),
        Container(
          height: double.maxFinite,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
              )
          ),
          margin: EdgeInsets.only(top: 120),
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Register Account", style: headingStyle),
                Text(
                  "Complete your details",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SocalCard(
                      icon: "assets/images/google.png",
                      press: () {
                        AuthService.signInWithGoogle().then((value){
                          getUserData();
                        }).onError((error, stackTrace){
                          CustomAlertDialogs.showFailuresDailog(context,error.toString());
                        });
                      },
                    ),
                    SocalCard(
                      icon: 'assets/images/facebook.png',
                      press: () {
                        AuthService.signInWithFacebook().then((value){
                          getUserData();
                        }).onError((error, stackTrace){
                          CustomAlertDialogs.showFailuresDailog(context,error.toString());
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                SignUpForm(),


                SizedBox(height: getProportionateScreenHeight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: getProportionateScreenWidth(16)),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, SignInScreen.routeName),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            color: kPrimaryColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

