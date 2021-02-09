import 'package:flutter/material.dart';
import 'package:sakoon/screens/splash/components/body.dart';
import 'file:///C:/Users/h/Downloads/Project/sakoon/sakoon/lib/data/size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
