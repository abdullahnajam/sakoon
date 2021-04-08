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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height*0.3,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Color(0xfffffbef),
                        Color(0xffdbf8fe),

                      ],
                    )
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding:EdgeInsets.all(10),
                          child: Image.asset('assets/images/menu.png',width: 25,height: 25,),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15,right: 15),
                          height: 40,
                          child: Row(
                            children: [
                              Icon(Icons.map_outlined,color: Colors.white,),
                              SizedBox(width: 7,),
                              Text("MAP",style: TextStyle(color: Colors.white),)
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(30)
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30,),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.place_outlined,color: Colors.grey[500],size: 20,),
                              Text("My Location",style: TextStyle(color: Colors.grey[500]),)
                            ],
                          ),
                          Text("CHOOSE SERVICES YOU",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w900),),
                          Text("WANT TO NEED",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w900),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                child: Container(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  height: 40,
                  width: 120,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.27,right: 10),
                  child: Row(
                    children: [
                      Icon(Icons.search,color: Colors.white,),
                      SizedBox(width: 7,),
                      Text("Search",style: TextStyle(color: Colors.white),)
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xffffcb51),
                      borderRadius: BorderRadius.circular(30)
                  ),
                ),
                alignment: Alignment.centerRight,
              )
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.7,
            child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                children: List.generate(2, (index) {
                  return Center(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Image.asset('assets/images/logo.png',width: 80,height: 80,),
                          Text("Title",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                  );
                }
                )
            ),
          )
   
    
        ],
      ),
    );
  }
}

