import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakoon/components/default_button.dart';
import 'package:sakoon/screens/home_nav/home_maintance.dart';

class HomePage extends StatefulWidget {
static String routename='/homepage';
@override
_HomePageState createState() => new _HomePageState();
}
class _HomePageState extends State<HomePage> {
  PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    super.initState();

  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        return Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              Container(
                height: 375,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 325,
                      child: PageView.builder(
                        itemBuilder: (context, position) {
                          return Container(
                              padding: EdgeInsets.only(bottom: 50),
                              height: 225,
                              decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('assets/images/sukoon.jpeg'),
                                  )
                              ),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,

                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text('',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(color: Colors.black,
                                            fontSize: 50,
                                            fontWeight: FontWeight.w600),),

                                    ],
                                  )
                              )
                          );
                        },
                        itemCount: 3, // Can be null
                      )
                    ),


                    Card(

                      margin: EdgeInsets.only(top: 300, left: 25, right: 25),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius
                          .circular(25),),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 1,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.search, color: Colors.grey[600]),
                              onPressed: () {

                              }),
                          Expanded(
                            child: Text("Search",style: TextStyle(
                                color: Colors.grey[600], fontSize: 18),)
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              //SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultButton(
                      text: "Fresh Work",
                      press: () {
                        Navigator.pushNamed(context,HomeMaintanance.routeName);
                      },
                    ),
                    SizedBox(height: 50,),
                    DefaultButton(
                      text: "Maintenance",
                      press: () {
                        Navigator.pushNamed(context,HomeMaintanance.routeName);
                      },
                    ),
                    SizedBox(height: 50,),
                    DefaultButton(
                      text: "Home Appliances",
                      press: () {
                      },
                    ),
                    SizedBox(height: 50,),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

