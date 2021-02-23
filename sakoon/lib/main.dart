import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sakoon/auth_block.dart';
import 'package:sakoon/data/routes.dart';
import 'package:sakoon/screens/sign_in/sign_in_screen.dart';
import 'package:sakoon/screens/splash/splash_screen.dart';
import 'package:sakoon/data/size_config.dart';
import 'package:sakoon/data/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Provider(
      create: (context) => AuthBlock(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        // home: SplashScreen(),
        // We use routeName so that we dont need to remember the name
        initialRoute: SignInScreen.routeName,
        routes: routes,
      ),
    );
  }
}
