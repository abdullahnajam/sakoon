import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakoon/data/constants.dart';
import 'package:sakoon/navigators/menu_drawer.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    void _openDrawer () {
      _drawerKey.currentState.openDrawer();
    }

    return Scaffold(
        backgroundColor: Colors.grey[200],
        key: _drawerKey,
        drawer: MenuDrawer(),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(width: 0.2, color: Colors.grey[500]),
                  ),

                ),
                child: Stack(
                  children: [
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child: Image.asset('assets/images/menu.png',width: 25,height: 25,color: kPrimaryColor,),
                      ),
                      onTap: ()=>_openDrawer(),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text("About Us",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 13),),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        child:
                        Image.asset('assets/images/logo.png',width: 200,height: 200,),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        child: Text('Our Company',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
                      ),

                      SizedBox(height: 5,),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text('Sukoon is a well-established company that provides you all kinds of products and services like providing and fixing Glass, packing and moving, construction, Property, UPVC and Aluminium, wood works and maintenance services of home appliance, Aluminium, Stainless Steel and UPVC and interior works. Working since the last 4 years, the company although yough has mounted massive experience in the relative field by working with big names in the construction industry.'),
                      ),

                      Container(
                        child: Text('Our Values',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text('Sukoon has clearly enunciated its corporate values and uses this charter in its day to day conduct of business as governing principles of behavior, attitude and actions. The matrix of values is derived from:'),
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Customer Focus')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Integrity')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Social Awareness ')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Market Leadership')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Environmental Protection')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Human Resource Development')
                      ),
                      Container(
                        child: Text('Our Vision',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Sukoon will maintain ethical integrity in all business dealings while striving to become the best supplie of quality products along with superior services to all customers and industries we may serve. We asprire to have a safe environment while promoting positive values and work ethics, competitive employment opportunities.')
                      ),
                      Container(
                        child: Text('Our Supply and Services',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Property')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Glass & Aluminium')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Architecture Consultancy')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Interior & Exterior Designing')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Packing & Moving')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Home Appliances Maintenance')
                      ),

                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Fresh work')
                      ),

                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Construction')
                      ),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xfffe734c),
                        ),
                          padding: EdgeInsets.all(10),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Contact Us",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Icon(Icons.email_outlined,color: Colors.white),
                                SizedBox(width: 10,),
                                Text("sukoon.business@gmail.com",style: TextStyle(color: Colors.white),),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Icon(Icons.phone_outlined,color: Colors.white),
                                SizedBox(width: 10,),
                                Text("03021030303",style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Icon(Icons.phone_outlined,color: Colors.white),
                                SizedBox(width: 10,),
                                Text("03195206631",style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            SizedBox(height: 5,),

                          ],
                        )
                      )

                    ],
                  ),
                ),
              ),

            ],
          ),
        )

    );
  }
}
