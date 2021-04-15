import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakoon/data/my_text.dart';
import 'package:sakoon/screens/about.dart';
import 'package:sakoon/screens/botton_nav/homePage.dart';
import 'package:sakoon/screens/partners.dart';
class MenuDrawer extends StatefulWidget {
  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(height: 30),
                 /* CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(Img.get("photo_male_6.jpg")),
                    ),
                  ),*/
                  Container(height: 7),
                  Text("My Name", style: MyText.body2(context).copyWith(
                      color: Colors.blueGrey[800], fontWeight: FontWeight.w500
                  )),
                  Container(height: 2),
                  Text("email@mail.com", style: MyText.caption(context).copyWith(
                      color: Colors.grey, fontWeight: FontWeight.w500
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
            InkWell(onTap: (){},
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
            InkWell(onTap: (){},
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
}
