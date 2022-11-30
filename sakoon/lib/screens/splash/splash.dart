import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sakoon/data/constants.dart';
import 'package:sakoon/screens/home/homePage.dart';
import 'package:sakoon/screens/sign_in/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 5;
  User user;

  getCurrentUser()async{
    user=await FirebaseAuth.instance.currentUser;
  }
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _loadWidget();
  }
  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }
  void navigationPage() {
    if(FirebaseAuth.instance.currentUser!=null){
      print('g auth user Id ${FirebaseAuth.instance.currentUser.uid}');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    }
    else{
      print('no user logged in');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => SignInScreen()));
    }
    /*FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => SignInScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        *//*Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));*//*
      }
    });*/
    /*if(user!=null){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    }
    else{
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => SignInScreen()));
    }*/

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height,
          child: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png',width: 150,height: 150,),
              Text("سکون زندگی میں",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w500,color: Colors.white),)
            ],
          )),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [ Color(0xffffb8a6),kPrimaryColor]))),
    );
  }
}

