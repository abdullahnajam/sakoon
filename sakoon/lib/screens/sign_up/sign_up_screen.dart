import 'package:flutter/material.dart';
import 'package:sakoon/data/constants.dart';

import '../../data/size_config.dart';
import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }
}
