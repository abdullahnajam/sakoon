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

      var KEYS= dataSnapshot.value.keys;
      var DATA=dataSnapshot.value;

      for(var individualKey in KEYS) {
        PartnerModel partnerModel = new PartnerModel(
          individualKey,
          DATA[individualKey]['name'],
          DATA[individualKey]['bio'],
          DATA[individualKey]['picture'],
        );
        print("key ${partnerModel.id}");
        list.add(partnerModel);

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
              FutureBuilder<List<PartnerModel>>(
                future: getPartnersList(),
                builder: (context,snapshot){
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                        shrinkWrap: true,
                        //scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context,int index){
                          return Container();
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
              )

            ],
          ),
        )

    );
  }
}
