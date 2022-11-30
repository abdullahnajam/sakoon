
import 'package:flutter/material.dart';

class MyText{



  static TextStyle display3(BuildContext context){
    return Theme.of(context).textTheme.displayLarge;
  }

  static TextStyle display2(BuildContext context){
    return Theme.of(context).textTheme.displayMedium;
  }

  static TextStyle display1(BuildContext context){
    return Theme.of(context).textTheme.displaySmall;
  }

  static TextStyle headline(BuildContext context){
    return Theme.of(context).textTheme.headlineLarge;
  }

  static TextStyle title(BuildContext context){
    return Theme.of(context).textTheme.titleMedium;
  }

  static TextStyle medium(BuildContext context){
    return Theme.of(context).textTheme.headlineSmall.copyWith(
      fontSize: 18,
    );
  }

  static TextStyle subhead(BuildContext context){
    return Theme.of(context).textTheme.headlineSmall;
  }

  static TextStyle body2(BuildContext context){
    return Theme.of(context).textTheme.bodySmall;
  }

  static TextStyle body1(BuildContext context){
    return Theme.of(context).textTheme.bodyMedium;
  }

  static TextStyle caption(BuildContext context){
    return Theme.of(context).textTheme.caption;
  }

  static TextStyle button(BuildContext context){
    return Theme.of(context).textTheme.button;
  }

  static TextStyle subtitle(BuildContext context){
    return Theme.of(context).textTheme.subtitle1;
  }

  static TextStyle overline(BuildContext context){
    return Theme.of(context).textTheme.overline;
  }
}