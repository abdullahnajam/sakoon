import 'package:flutter/material.dart';
import 'package:sakoon/data/constants.dart';

import '../../data/size_config.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }
}
