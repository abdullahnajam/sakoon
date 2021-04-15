import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sakoon/data/routes.dart';
import 'package:sakoon/screens/sign_in/sign_in_screen.dart';
import 'package:sakoon/data/size_config.dart';
import 'package:sakoon/data/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sakoon/screens/splash/splash.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Sukoon',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
