import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakoon/data/constants.dart';
import 'package:sakoon/data/size_config.dart';
import 'complete_profile_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Row(
            children: [
              Text("Complete Profile",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),)
            ],
          ),
          margin: EdgeInsets.only(top: 50,left: 20),
        ),
        Container(
          margin: EdgeInsets.only(top: 120),
          height: double.maxFinite,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
              )
          ),
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text("Fill the details", style: headingStyle),
                Text("Complete your personal information", textAlign: TextAlign.center,),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                CompleteProfileForm(),
                SizedBox(height: getProportionateScreenHeight(30)),

              ],
            ),
          ),
        ),
      ],
    );
  }
}
