import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

import '../../api/location.dart';

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

  getUserData() async{
    final ref = FirebaseDatabase.instance.ref('user/${ FirebaseAuth.instance.currentUser.uid}');
    DatabaseEvent event = await ref.once();
    print('user ref ${event.snapshot.value}');
    if (event.snapshot.value!=null) {
      Map<dynamic, dynamic> values = event.snapshot.value;
      setState(() {
        username='${values['firstName']}  ${values['lastName']}';
        location='${values['address']}';

        userData=UserData(FirebaseAuth.instance.currentUser.uid, values['firstName'], values['lastName'], values['phoneNumber'], values['email'], values['address']);
      });

    } else {
      print('No data available.');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => CompleteProfileScreen()));
    }
  }


  @override
  void initState() {
    super.initState();
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








  Future<List<BannerModel>> getBanner() async {
    List<BannerModel> list=[];
    final ref = FirebaseDatabase.instance.ref("banner");
    DatabaseEvent event = await ref.once();
    if(event.snapshot.value!=null){
      Map<dynamic, dynamic> values = event.snapshot.value;
      values.forEach((key, values) {
        BannerModel _banner=BannerModel(
          key,
          values['url'],
        );
        list.add(_banner);
      });
    }

    return list;
  }

  Future<List<Service>> getServices() async {
    List<Service> list=[];
    final ref = FirebaseDatabase.instance.ref("services");
    DatabaseEvent event = await ref.once();
    if(event.snapshot.value!=null){
      Map<dynamic, dynamic> values = event.snapshot.value;
      values.forEach((key, values) {
        Service _service=Service(
          key,
          values['name'],
          values['image'],
          values['count'],
        );
        if(values['sub_services']==null){
          _service.count='0';
        }
        else
          _service.count=values['sub_services'].length.toString();
        list.add(_service);
      });
    }
    return list;
  }


  setLocation()async{
    List coordinates=await getUserCurrentCoordinates();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey: kGoogleApiKey,
          onPlacePicked: (result) {
            setState(() {
              location=result.formattedAddress;
            });
            User user= FirebaseAuth.instance.currentUser;
            final databaseReference = FirebaseDatabase.instance.reference();
            databaseReference.child("user").child(user.uid).update({
              'address': location,
            });


            Navigator.of(context).pop();
          },
          initialPosition: LatLng(coordinates[0], coordinates[1]),
          useCurrentLocation: true,
        ),
      ),
    );

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
                height: MediaQuery.of(context).size.height*0.4,
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
                            margin: EdgeInsets.only(top: 10),
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
                              Icon(Icons.place_outlined,color: Colors.white,size: 12,),
                              Expanded(child: Text("${location}",style: TextStyle(color: Colors.white,fontSize: 11),maxLines: 1,))
                            ],
                          ),
                          Text("HOME SERVICES AT YOUR DOORSTEP",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w900),),
                          //Text("WANT TO NEED",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w900),)
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),

                  ],
                ),
              ),
              Align(
                child: Container(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
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
          Expanded(
            //height: MediaQuery.of(context).size.height*0.39,
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
                          onTap: () async{
                            if(location=='My Location'){
                              setLocation();
                            }
                            else{
                              User user= FirebaseAuth.instance.currentUser;
                              final databaseReference = FirebaseDatabase.instance.ref();
                              try{
                                databaseReference.child("activities").push().set({
                                  'name': "${userData.firstName} ${userData.lastName}",
                                  'email': userData.email,
                                  'phone': userData.phoneNumber,
                                  'address': location,
                                  'user': user.uid,
                                  'serviceTapped': snapshot.data[index].name,
                                  'dateTime': DateFormat.yMd().add_jm().format(DateTime.now())
                                }).then((value){
                                  print('inserted');
                                }).onError((error, stackTrace){
                                  print('set error ${error.toString()}');
                                });
                              }
                              catch(e){
                                print('set error ${e.toString()}');
                              }
                            var data={
                                "message": '"${userData.firstName} ${userData.lastName} has clicked on ${snapshot.data[index].name}',


                              };
                              //await http.post(Uri.parse('https://sukoonadmin.000webhostapp.com/Notification.php'), body: data);
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ServicesCheckList(snapshot.data[index],location,userData)));
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

