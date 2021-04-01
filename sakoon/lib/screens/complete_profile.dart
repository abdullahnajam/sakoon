import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakoon/data/constants.dart';
import 'package:sakoon/screens/botton_nav/homePage.dart';

class SetUserInfo extends StatefulWidget {
  String uid;

  SetUserInfo(this.uid);

  @override
  _SetUserInfoState createState() => _SetUserInfoState();
}

class _SetUserInfoState extends State<SetUserInfo> {
  final emailController=TextEditingController();
  final nameController=TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: kPrimaryColor,),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20,left: 20),
                  child: Text(
                    ' Complete Profile',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15,left: 20),
                  child: Text("  Phone Number",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 13),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: emailController,
                    style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom:-20.0),
                        hintText: "",
                        hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 18)
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only(top: 15,left: 20),
                  child: Text("Address",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 13),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: nameController,
                    style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom:-20.0),
                        hintText: "",
                        hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 18)
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Align(
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width*0.8,
                    child: RaisedButton(
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                                (route) => false);
                       /* if (_formKey.currentState.validate()){
                          final databaseReference = FirebaseDatabase.instance.reference().child("User");
                          databaseReference.child(widget.uid).set({
                            'email': emailController.text,
                            'name': nameController.text,
                            'surname': 'none',
                            'gender': 'none',
                            'phoneCode': widget.phoneCode,
                            'phoneNumber': widget.phoneNumber,
                            'countryCode': widget.flag
                          });
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => BottomNavBar(widget.uid,true)),
                                  (route) => false);
                        }*/
                      },
                      color: kPrimaryColor,
                      child: Text("CONFIRM",style: TextStyle(color:Colors.white,fontWeight: FontWeight.w500,fontSize: 18)),
                    ),
                  ),
                  alignment: Alignment.center,
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.center,
                  child: Text("By Selecting confirm you agree to\nT\&C\'s and Privacy Policy",textAlign: TextAlign.center,style: TextStyle(color:Colors.grey[400],fontWeight: FontWeight.w400,fontSize: 12)),
                )

              ],
            ),
          )
      ),
    );
  }
}
