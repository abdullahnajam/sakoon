import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:sakoon/components/default_button.dart';
import 'package:sakoon/data/constants.dart';
import 'package:sakoon/model/banner.dart';
import 'package:sakoon/model/services.dart';
import 'package:sakoon/model/sub_services.dart';
import 'package:sakoon/model/user_data.dart';
import 'package:sakoon/navigators/menu_drawer.dart';
import 'package:sakoon/screens/complete_profile/complete_profile_screen.dart';
import 'package:sakoon/screens/services_list.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
static String routename='/homepage';
@override
_HomePageState createState() => new _HomePageState();
}
class _HomePageState extends State<HomePage> {
  PageController controller = PageController(
    initialPage: 0,
  );
  String username="username";
  String location="My Location";
  UserData userData;

  List<int> totalServicesAvailable=[];
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  getUser() async{
    User user= FirebaseAuth.instance.currentUser;
    print("user id ${user.uid}");
    setState(() {
      username=user.uid;
    });
  }
  @override
  void initState() {
    super.initState();
    print(totalServicesAvailable.length);
    getUserData();
  }


  void _openDrawer () {
    _drawerKey.currentState.openDrawer();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  getUserData() async{
    User user= FirebaseAuth.instance.currentUser;
    final userReference = FirebaseDatabase.instance.reference();
    await userReference.child("user").child(user.uid).once().then((DataSnapshot dataSnapshot){
      if(dataSnapshot.value == null){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CompleteProfileScreen()));
      }
      else{
        setState(() {
          location=dataSnapshot.value['address'];
          username=dataSnapshot.value['firstName'];
        });

      }


    });
  }







  Future<List<BannerModel>> getBanner() async {
    List<BannerModel> list=new List();
    final databaseReference = FirebaseDatabase.instance.reference();
    await databaseReference.child("banner").once().then((DataSnapshot dataSnapshot){

      var KEYS= dataSnapshot.value.keys;
      var DATA=dataSnapshot.value;

      for(var individualKey in KEYS) {
        BannerModel bannerModel = new BannerModel(
          individualKey,
          DATA[individualKey]['url'],
        );
        print("key ${bannerModel.id}");
        list.add(bannerModel);

      }
    });
    return list;
  }

  Future<List<Service>> getServices() async {
    List<Service> list=new List();
    final databaseReference = FirebaseDatabase.instance.reference();
    await databaseReference.child("services").once().then((DataSnapshot dataSnapshot){

      var KEYS= dataSnapshot.value.keys;
      var DATA=dataSnapshot.value;

      for(var individualKey in KEYS) {
        Service service = new Service(
            individualKey,
            DATA[individualKey]['name'],
            DATA[individualKey]['image'],
            DATA[individualKey]['count'],
        );
        print("key ${service.id}");
        list.add(service);

      }
    });
    return list;
  }
  setLocation()async{
    LocationResult result = await showLocationPicker(
      context,
      kGoogleApiKey,
    );
    if(result!=null){
      setState(() {
        location=result.address;
      });
      User user= FirebaseAuth.instance.currentUser;
      final databaseReference = FirebaseDatabase.instance.reference();
      databaseReference.child("user").child(user.uid).update({
        'address': location,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: MenuDrawer(),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 35),
                height: MediaQuery.of(context).size.height*0.45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Color(0xfffe734c),
                        Color(0xfffe734c)

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
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: _openDrawer,
                                child: Image.asset('assets/images/menu.png',width: 25,height: 25,),
                              ),
                              SizedBox(width: 10,),
                              Text("Hi, $username",style: TextStyle(color: Colors.white,fontSize: 16),)
                            ],
                          )

                        ),
                        GestureDetector(
                          onTap: () {
                            setLocation();
                          },
                          child: Container(
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
                                color: Color(0xffffb8a6),
                                borderRadius: BorderRadius.circular(30)
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.place_outlined,color: Colors.white,size: 20,),
                              Text("${location}",style: TextStyle(color: Colors.white),maxLines: 1,)
                            ],
                          ),
                          Text("HOME SERVICES AT YOUR DOORSTEP",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w900),),
                          //Text("WANT TO NEED",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w900),)
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Icon(Icons.search,color: Colors.grey,),
                          Text("Search")
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                child: Container(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.35),
                  child: FutureBuilder<List<BannerModel>>(
                    future: getBanner(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          return  Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height*0.18,
                                width: double.maxFinite,
                                child: PageView.builder(
                                    controller: controller,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, position){
                                      return Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: ClipRRect(
                                          borderRadius:  BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot.data[position].url,
                                            fit: BoxFit.cover,
                                            height: double.maxFinite,
                                            width: double.maxFinite,
                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                Center(child: CircularProgressIndicator(),),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                        ),

                                      );
                                    }
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: SmoothPageIndicator(
                                  controller: controller,
                                  count: snapshot.data.length,
                                  effect: WormEffect(dotWidth: 10,dotHeight:10,activeDotColor: kPrimaryColor,dotColor: Colors.grey[200]),
                                ),
                              ),
                            ],
                          );
                        }
                        else {
                          return new Center(
                            child: Container(
                                child: Text("no data")
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

                ),
                alignment: Alignment.bottomCenter,
              )
            ],
          ),
          /*Container(
            padding: EdgeInsets.only(top: 10,bottom: 10),
            height: MediaQuery.of(context).size.height*0.25,
            child: PageView.builder(
                itemCount: 5,
                itemBuilder: (context, position){
                  return Image.asset("assets/images/logo.png");
                }
            ),
          ),*/
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 10,top: 10),
            child: Text("Which service do you need?",style: TextStyle(color: kPrimaryColor,fontSize: 20,fontWeight: FontWeight.w900),),

          ),
          Container(
            height: MediaQuery.of(context).size.height*0.39,
            child: FutureBuilder<List<Service>>(
              future: getServices(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      shrinkWrap: true,
                      //scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context,int index){
                        return GestureDetector(
                          onTap: () {
                            if(location=="My Location"){
                              setLocation();
                            }
                            else{
                              final scaffold = Scaffold.of(context);
                              User user= FirebaseAuth.instance.currentUser;
                              final databaseReference = FirebaseDatabase.instance.reference();
                              databaseReference.child("activities").push().set({
                                'address': location,
                                'user': user.uid,
                                'serviceTapped': snapshot.data[index].name,
                              });
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (BuildContext context) => ServicesCheckList(snapshot.data[index],location)));
                            }

                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                            padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: Color(0xfff4f6f5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              leading: CachedNetworkImage(
                                imageUrl: snapshot.data[index].imgUrl,
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                              title: Text(snapshot.data[index].name.toString(),style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w400),),
                              subtitle: int.parse(snapshot.data[index].count)>1?
                              Text('${snapshot.data[index].count} services'):
                              Text('${snapshot.data[index].count} service')
                            ),
                          ),
                        );
                      },
                    );
                  }
                  else {
                    return new Center(
                      child: Container(
                        child: Text("no data")
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
