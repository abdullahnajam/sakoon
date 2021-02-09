import 'package:flutter/material.dart';
import 'package:sakoon/components/default_button.dart';
import 'package:sakoon/screens/home/home_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: MediaQuery.of(context).size.height * 0.4, //40%
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        Text(
          "Login Success",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: MediaQuery.of(context).size.height * 0.6,
          child: Container(
            child: DefaultButton(
              text: "Back to home",
              press: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
            ),
            margin: EdgeInsets.all(50),
          )
        ),
        Spacer(),
      ],
    );
  }
}
