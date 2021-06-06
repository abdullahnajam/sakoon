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
                        child: Text('Due to Pandemic . many of the Workers who supply things and do Maintenance at your homes are jobless. So to provide them Work , we are introducing this Sukoon app which will also help you to get in touch with one of the best workers and vendors who will provide you the work and maintenance of any type you need. If you want something to be supplied at your home. Sukoon is here for you.'),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text('Sukoon.PVT LTD is a well-established company that provides services, maintenance and supply of all kinds of local & imported Glass, Aluminum, Stainless Steel, wood work, UPVC, Electric work, plumbing work . '),
                      ),
                      Container(
                        child: Text('Our Values',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
                      ),
                      SizedBox(height: 5,),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Customer Satisfaction')
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
                          child: Text('Human Resource Development')
                      ),
                      Container(
                        child: Text('Our Vision',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Sukoon will maintain ethical integrity in all business dealings while striving to become the best supplier of quality products along with superior services to all customers and industries we may serve. We aspire to have a safe environment while promoting positive values and work ethics, competitive employment opportunities.')
                      ),
                      Container(
                        child: Text('Our Supply and Services',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Wood')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Aluminium')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Glass')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Plaster of Paris')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Structure')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Electrical Work')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Marble')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Air Conditioner')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Solar work')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Steel Work')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Plumbing work')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Paint work')
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('Supply')
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
                                Text("deenenterprises252@gmail.com",style: TextStyle(color: Colors.white),),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Icon(Icons.phone_outlined,color: Colors.white),
                                SizedBox(width: 10,),
                                Text("03045306074",style: TextStyle(color: Colors.white)),
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
