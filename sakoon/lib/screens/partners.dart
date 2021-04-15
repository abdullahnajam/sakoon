import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakoon/navigators/menu_drawer.dart';
class Partners extends StatefulWidget {
  @override
  _PartnersState createState() => _PartnersState();
}

class _PartnersState extends State<Partners> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      body: Container(),
    );
  }
}
