import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sakoon/data/constants.dart';
import 'package:sakoon/model/services.dart';
import 'package:sakoon/model/sub_services.dart';

class ServicesCheckList extends StatefulWidget {
  Service _service;

  ServicesCheckList(this._service);


  @override
  _ServiceCheckListState createState() => _ServiceCheckListState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _ServiceCheckListState extends State<ServicesCheckList> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  List<bool> isCheck=[];
  final databaseReference = FirebaseDatabase.instance.reference();

  Future<List<SubService>> getServiceList() async {
    List<SubService> list=[];
    isCheck.clear();
    await databaseReference.child("services").child(widget._service.id).child("sub_services").once().then((DataSnapshot dataSnapshot){
      if(dataSnapshot.value!=null){
        var KEYS= dataSnapshot.value.keys;
        var DATA=dataSnapshot.value;
        if(KEYS!=null){
          for(var individualKey in KEYS){
            SubService _subService = new SubService(
                individualKey,
                DATA[individualKey]['name']
            );
            print("key ${_subService.id}");
            list.add(_subService);
            isCheck.add(false);
          }
        }
      }


    });

    return list;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 160.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('SliverAppBar'),
              background: FlutterLogo(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effect.'),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return FutureBuilder<List<SubService>>(
                  future: getServiceList(),
                  builder: (context,snapshot){
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        return ListView.builder(
                          shrinkWrap: true,
                          //scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context,int index){
                            return CheckboxListTile(
                                title: Text(snapshot.data[index].name),
                                value: isCheck[index],
                                activeColor: kPrimaryColor,
                                onChanged: (bool value){
                                  setState(() {
                                    isCheck[index]=value;
                                  });
                                }
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
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),

    );
  }
}
