import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakoon/data/constants.dart';
import 'package:sakoon/model/partners.dart';
import 'package:sakoon/navigators/menu_drawer.dart';
class Partners extends StatefulWidget {
  @override
  _PartnersState createState() => _PartnersState();
}

class _PartnersState extends State<Partners> {

  Future<List<PartnerModel>> getPartnersList() async {
    List<PartnerModel> list=new List();
    final databaseReference = FirebaseDatabase.instance.reference();
    await databaseReference.child("partners").once().then((DataSnapshot dataSnapshot){

      if(dataSnapshot.value!=null){
        var KEYS= dataSnapshot.value.keys;
        var DATA=dataSnapshot.value;

        for(var individualKey in KEYS) {
          PartnerModel partnerModel = new PartnerModel(
            individualKey,
            DATA[individualKey]['name'],
            DATA[individualKey]['url'],
          );
          print("key ${partnerModel.id}");
          list.add(partnerModel);

        }
      }
    });
    return list;
  }

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  void _openDrawer () {
    _drawerKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      child: Text("Partners",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 13),),
                    ),


                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<List<PartnerModel>>(
                  future: getPartnersList(),
                  builder: (context,snapshot){
                    if (snapshot.hasData) {
                      if (snapshot.data != null && snapshot.data.length>0) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(

                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius:  BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot.data[index].url,
                                          fit: BoxFit.cover,
                                          height: 200,
                                          width: double.maxFinite,
                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                              Center(child: CircularProgressIndicator(),),
                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                        ),
                                      ),
                                      Container(
                                        margin:EdgeInsets.all(5),
                                        child: Text(snapshot.data[index].name,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              );
                            });
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
        )

    );
  }
}
