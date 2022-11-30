import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakoon/data/my_text.dart';
import 'package:sakoon/projects.dart';
import 'package:sakoon/screens/about.dart';
import 'package:sakoon/screens/complete_profile/complete_profile_screen.dart';
import 'package:sakoon/screens/home/homePage.dart';
import 'package:sakoon/screens/partners.dart';
import 'package:sakoon/screens/sign_in/sign_in_screen.dart';
class MenuDrawer extends StatefulWidget {
  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  String name=" ",email=" ";
  Future getUserData() async{
    final ref = FirebaseDatabase.instance.ref('user/${FirebaseAuth.instance.currentUser.uid}');
    DatabaseEvent event = await ref.once();

    if (event.snapshot.value!=null) {
      Map<dynamic, dynamic> values = event.snapshot.value;
      print('service data ${values['firstName']}');
      setState(() {
        name=' ${values['firstName']}  ${values['lastName']}';
        email=' ${values['email']}';
      });

      print('user val ${event.snapshot.value}');
    } else {
      print('No data available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.jpg'),
                      fit: BoxFit.cover
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(height: 30),
                  //Image.asset('assets/images/background.jpg'),
                  Container(height: 7),
                  Text(name, style: MyText.body2(context).copyWith(
                      color: Colors.black, fontWeight: FontWeight.w500
                  )),
                  Container(height: 2),
                  Text(email, style: MyText.caption(context).copyWith(
                      color: Colors.black, fontWeight: FontWeight.w500
                  ))
                ],
              ),
            ),
            Container(height: 8),
            InkWell(onTap: (){
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
            },
              child: Container(height: 40, padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.home_outlined, color: Colors.grey, size: 20),
                    Container(width: 20),
                    Expanded(child: Text("Home", style: MyText.body2(context).copyWith(color: Colors.grey))),
                  ],
                ),
              ),
            ),
            Container(height: 10),
            InkWell(onTap: (){
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (BuildContext context) => Projects()));
            },
              child: Container(height: 40, padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.work_outline, color: Colors.grey, size: 20),
                    Container(width: 20),
                    Expanded(child: Text("Projects", style: MyText.body2(context).copyWith(color: Colors.grey))),
                  ],
                ),
              ),
            ),
            Container(height: 10),
            InkWell(onTap: (){
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (BuildContext context) => AboutUs()));
            },
              child: Container(height: 40, padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.person_outline, color: Colors.grey, size: 20),
                    Container(width: 20),
                    Expanded(child: Text("About Us", style: MyText.body2(context).copyWith(color: Colors.grey))),
                  ],
                ),
              ),
            ),
            Container(height: 10),
            InkWell(onTap: (){
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (BuildContext context) => Partners()));
            },
              child: Container(height: 40, padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.people_outline, color: Colors.grey, size: 20),
                    Container(width: 20),
                    Expanded(child: Text("Partners", style: MyText.body2(context).copyWith(color: Colors.grey))),
                  ],
                ),
              ),
            ),
            Container(height: 10),
            InkWell(onTap: () async{
              await FirebaseAuth.instance.signOut().whenComplete((){
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (BuildContext context) => SignInScreen()));
              });
            },
              child: Container(height: 40, padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.power_settings_new, color: Colors.grey, size: 20),
                    Container(width: 20),
                    Expanded(child: Text("Logout", style: MyText.body2(context).copyWith(color: Colors.grey))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }
}
