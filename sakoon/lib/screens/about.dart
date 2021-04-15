import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakoon/navigators/menu_drawer.dart';
class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      body: Container(),
    );  }
}
