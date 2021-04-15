import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakoon/data/constants.dart';
import 'package:sakoon/model/services.dart';
import 'package:sakoon/model/sub_services.dart';
class ServicesCheckList extends StatefulWidget {
  Service _service;
  @override
  _ServicesCheckListState createState() => _ServicesCheckListState();

  ServicesCheckList(this._service);
}

class _ServicesCheckListState extends State<ServicesCheckList> {
  ScrollController _scrollController;

  bool lastStatus = true;
  List<bool> isCheck=[];

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }
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
      backgroundColor: Colors.white,
      body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: isShrink
                    ? Icon(
                  Icons.arrow_back,
                  color: kPrimaryColor,
                )
                    : GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(10),
                    child: Icon(
                      Icons.arrow_back,
                      color: kPrimaryColor,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(120),
                    ),
                  ),
                ),
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: !isShrink
                        ? Text("", style: TextStyle(color: Colors.white, fontSize: 16.0,))
                        : Text(widget._service.name, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.black),),
                    background: Container(
                        child: Container(
                          margin: EdgeInsets.only(top: 100, left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget._service.name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700)),
                              GestureDetector(
                                onTap: () {},
                                child: Text("Find Out More",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      decoration: TextDecoration.underline,
                                      decorationStyle: TextDecorationStyle.solid,
                                      decorationColor: kPrimaryColor, decorationThickness: 1,
                                    )),
                              )
                            ],
                          ),
                        ),
                        decoration: new BoxDecoration(color: Colors.amberAccent
                          /*image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new AssetImage("assets/images/relax.png"),
                          )*/
                        ))),
              ),
            ];
          },
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  child: FutureBuilder<List<SubService>>(
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
                  ),
                )

              ],
            ),
          )
      ),
    );
  }
}
