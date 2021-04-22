import 'package:flutter/widgets.dart';
import 'package:sakoon/screens/complete_profile/complete_profile_screen.dart';
import 'package:sakoon/screens/forgot_password/forgot_password_screen.dart';
import 'package:sakoon/screens/home/homePage.dart';
import 'package:sakoon/screens/sign_in/sign_in_screen.dart';
import 'package:sakoon/screens/splash/splash.dart';
import '../screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  HomePage.routename: (context) => HomePage(),
};
