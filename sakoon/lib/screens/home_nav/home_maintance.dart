import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakoon/components/default_button.dart';
import 'package:sakoon/data/constants.dart';
class HomeMaintanance extends StatefulWidget {
  static String routeName = "/home_maintainance";
  @override
  _HomeMaintananceState createState() => _HomeMaintananceState();
}

class _HomeMaintananceState extends State<HomeMaintanance> {
  bool _isWoodChecked=false;
  bool _isAlluminiumChecked=false;
  bool _isGlassChecked=false;
  bool _isPlasterChecked=false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Text("Please select the work",textAlign: TextAlign.center,style: TextStyle(color: kPrimaryColor,fontSize: 25,fontWeight: FontWeight.w500),),
              ),
            ),
            Expanded(
              flex: 8,
              child: ListView(
                children: [

                  CheckboxListTile(
                      title: Text("Wood"),
                      value: _isWoodChecked,
                      activeColor: kPrimaryColor,
                      onChanged: (bool value){
                        setState(() {
                          _isWoodChecked=value;
                        });
                      }
                  ),
                  CheckboxListTile(
                      title: Text("Plaster"),
                      value: _isPlasterChecked,
                      activeColor: kPrimaryColor,
                      onChanged: (bool value){
                        setState(() {
                          _isPlasterChecked=value;
                        });
                      }
                  ),
                  CheckboxListTile(
                      title: Text("Alluminium"),
                      value: _isAlluminiumChecked,
                      activeColor: kPrimaryColor,
                      onChanged: (bool value){
                        setState(() {
                          _isAlluminiumChecked=value;
                        });
                      }
                  ),
                  CheckboxListTile(
                      title: Text("Glass"),
                      value: _isGlassChecked,
                      activeColor: kPrimaryColor,
                      onChanged: (bool value){
                        setState(() {
                          _isGlassChecked=value;
                        });
                      }
                  ),


                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: DefaultButton(
                  text: "Submit",
                  press: () {
                    //Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                ),
                margin: EdgeInsets.only(left: 30,right: 30,bottom: 10),
              ),
            )
          ],
        ),
      )

    );
  }
}
