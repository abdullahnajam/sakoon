import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sakoon/components/default_button.dart';
import 'package:sakoon/data/constants.dart';
import 'package:sakoon/model/services.dart';
import 'package:sakoon/model/sub_services.dart';
import 'home/homePage.dart';

class ServicesCheckList extends StatefulWidget {
  Service _service;
  String location;

  ServicesCheckList(this._service,this.location);


  @override
  _ServiceCheckListState createState() => _ServiceCheckListState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _ServiceCheckListState extends State<ServicesCheckList> {
  bool isSelected=false;

  List<bool> isCheck=[];
  List<SubService> serviceItems=[];
  final databaseReference = FirebaseDatabase.instance.reference();

  checkSelected(){
    int selected=0;
    for(int i=0;i<isCheck.length;i++){
      if(isCheck[i]==true){
        selected++;
      }
    }
    if(selected>0){
      setState(() {
        isSelected=true;
      });
    }
    else{
      setState(() {
        isSelected=false;
      });
    }
  }
  submitData(){
    List<String> checkedItems=[];
    for(int i=0;i<isCheck.length;i++){
      if(isCheck[i]){
        checkedItems.add(serviceItems[i].name);
      }
    }
    User user= FirebaseAuth.instance.currentUser;
    final databaseReference = FirebaseDatabase.instance.reference();
    databaseReference.child("requests").push().set({
      'serviceList': checkedItems,
      'serviceId': widget._service.id,
      'serviceName': widget._service.name,
      'user': user.uid,
      'time': DateTime.now().toString(),
      'address':widget.location
    }).then((value) {
      _showSuccessDailog();
    }).catchError((onError){
      _showFailuresDailog(onError.toString());
    });
  }

  Future<void> _showSuccessDailog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          insetAnimationDuration: const Duration(seconds: 1),
          insetAnimationCurve: Curves.fastOutSlowIn,
          elevation: 2,
          
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Lottie.asset(
                    'assets/json/success.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text("Successful",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),),
                      Text("Your request has been submitted",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),),
                    ],
                  )

                ),
                Container(
                  margin: EdgeInsets.only(top:20,left: 20,right: 20,bottom: 20),
                  child: Divider(color: Colors.grey,),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    height: 40,
                    margin: EdgeInsets.only(left: 40,right: 40),
                    child:Text("OKAY",style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w400),),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showFailuresDailog(String error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          insetAnimationDuration: const Duration(seconds: 1),
          insetAnimationCurve: Curves.fastOutSlowIn,
          elevation: 2,

          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Lottie.asset(
                    'assets/json/error.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                    child: Column(
                      children: [
                        Text("Error",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),),
                        Text(error,textAlign: TextAlign.center,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),),
                      ],
                    )

                ),
                Container(
                  margin: EdgeInsets.only(top:20,left: 20,right: 20,bottom: 20),
                  child: Divider(color: Colors.grey,),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    height: 40,
                    margin: EdgeInsets.only(left: 40,right: 40),
                    child:Text("OKAY",style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.w400),),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<List<SubService>> getServiceList() async {
    List<SubService> list=[];
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
            serviceItems.add(_subService);
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
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                height: isSelected ? 60.0 : 0.0,
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: GestureDetector(
                  onTap: (){
                    _showSuccessDailog();
                    //submitData();
                  },
                  child: Container(
                    height: 40,
                    width: double.maxFinite,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 18),),
                    margin: EdgeInsets.only(left: 20,right: 20,bottom: 15),
                  ),
                )
              ),
            ),
            Column(
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
                          child: Icon(Icons.arrow_back,color: kPrimaryColor,),
                        ),
                        onTap: ()=>Navigator.pop(context),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text("${widget._service.name}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 13),),
                      ),


                    ],
                  ),
                ),
                FutureBuilder<List<SubService>>(
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
                                    print("index $index");
                                    isCheck[index]=value;

                                  });
                                  checkSelected();
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
                )

              ],
            )
          ],
        ),
      )

    );
  }
}
