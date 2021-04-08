import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakoon/components/default_button.dart';
import 'package:sakoon/model/services.dart';
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

  final databaseReference = FirebaseDatabase.instance.reference();

  Future<List<Service>> getServices() async {
    List<Service> list=new List();
    await databaseReference.child("services").once().then((DataSnapshot dataSnapshot){

      var KEYS= dataSnapshot.value.keys;
      var DATA=dataSnapshot.value;

      for(var individualKey in KEYS){
        Service service = new Service(
            individualKey,
            DATA[individualKey]['name'],
            DATA[individualKey]['image']
        );
        print("key ${service.id}");
        list.add(service);



      }
    });
    return list;
  }

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
                height: MediaQuery.of(context).size.height*0.28,
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
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25,right: 10),
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
            padding: EdgeInsets.only(top: 10,bottom: 10),
            height: MediaQuery.of(context).size.height*0.25,
            child: PageView.builder(
                itemCount: 5,
                itemBuilder: (context, position){
                  return Image.asset("assets/images/logo.png");
                }
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.45,
            child: FutureBuilder<List<Service>>(
              future: getServices(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context,int index){
                        return Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Color(0xff6db0f2),
                                  Color(0xff498fd5),

                                ],
                              ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data[index].imgUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child:  Text(snapshot.data[index].name,textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w400),),
                              )

                            ],
                          ),
                        );
                      },
                    );
                  }
                  else {
                    return new Center(
                      child: Container(
                        child: Text("No Data Found"),
                      ),
                    );
                  }
                }
                else if (snapshot.hasError) {
                  return Text('Error : ${snapshot.error}');
                } else {
                  return new Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
   
    
        ],
      ),
    );
  }
}

