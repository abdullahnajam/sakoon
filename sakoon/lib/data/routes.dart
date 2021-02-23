import 'package:flutter/widgets.dart';
import 'package:sakoon/navigators/bottom_nav_bar.dart';
import 'package:sakoon/screens/botton_nav/homePage.dart';
import 'package:sakoon/screens/complete_profile/complete_profile_screen.dart';
import 'package:sakoon/screens/forgot_password/forgot_password_screen.dart';
import 'package:sakoon/screens/home/home_screen.dart';
import 'package:sakoon/screens/home_nav/home_maintance.dart';
import 'package:sakoon/screens/login_success/login_success_screen.dart';
import 'package:sakoon/screens/sign_in/sign_in_screen.dart';
import 'package:sakoon/screens/splash/splash_screen.dart';

import '../screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  HomeScreen.routeName: (context) => Home(),
  HomeMaintanance.routeName: (context) => HomeMaintanance(),
  HomePage.routename: (context) => HomePage(),
};
