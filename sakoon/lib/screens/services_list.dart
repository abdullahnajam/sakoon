import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sakoon/components/default_button.dart';
import 'package:sakoon/dailogs/custom_alert_dialogs.dart';
import 'package:sakoon/data/constants.dart';
import 'package:sakoon/model/services.dart';
import 'package:sakoon/model/sub_services.dart';
import 'package:http/http.dart' as http;


import 'package:sakoon/model/user_data.dart';
import 'home/homePage.dart';

class ServicesCheckList extends StatefulWidget {
  Service _service;
  String location;
  UserData userData;

  ServicesCheckList(this._service,this.location,this.userData);


  @override
  _ServiceCheckListState createState() => _ServiceCheckListState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _ServiceCheckListState extends State<ServicesCheckList> {
  bool isSelected=false;

  List<bool> isCheck=[];
  List<SubService> serviceItems=[];
  final databaseReference = FirebaseDatabase.instance.ref();

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
  Future submitData()async{
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
      'name': "${widget.userData.firstName} ${widget.userData.lastName}",
      'email': widget.userData.email,
      'phone': widget.userData.phoneNumber,
      'time': DateFormat.yMd().add_jm().format(DateTime.now()),
      'address':widget.location
    }).then((value) async{
      var data={
        "message": '"${widget.userData.firstName} ${widget.userData.lastName} has submitted list of services for ${widget._service.name}',


      };
      /*await http.post(Uri.parse('https://sukoonadmin.000webhostapp.com/Notification.php'), body: data).then((res) {
        print('${res.statusCode}+${res.body}');

      }).catchError((err) {
        print("error"+err.toString());

      });*/
      CustomAlertDialogs.showServiceSubmitDialog(context, "Your request has been submitted");

    }).catchError((onError){
      CustomAlertDialogs.showFailuresDailog(context,onError.toString());
    });
  }



  Future<List<SubService>> getServiceList() async {
    List<SubService> list=[];
    final ref = FirebaseDatabase.instance.ref("services/${widget._service.id}/sub_services");
    DatabaseEvent event = await ref.once();
    if(event.snapshot.value!=null){
      Map<dynamic, dynamic> values = event.snapshot.value;
      values.forEach((key, values) {

        SubService _subService=SubService(
          key,
          values['name'],
        );
        list.add(_subService);
        serviceItems.add(_subService);
        isCheck.add(false);
        print('lists ${serviceItems.last.name}');
      });
    }


    return list;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [

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
                  Expanded(
                    child: FutureBuilder<List<SubService>>(
                      future: getServiceList(),
                      builder: (context,snapshot){
                        if (snapshot.hasData) {
                          if (snapshot.data != null) {
                            return ListView.builder(
                              shrinkWrap: true,
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
                    ),
                  ),
                  if(isSelected)
                  SizedBox(height: 60,)

                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child:  AnimatedContainer(
                    color: Colors.white,
                    height: isSelected ? 60.0 : 0.0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    child: GestureDetector(
                      onTap: (){
                        submitData();
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
            ],
          ),
        )

    );
  }
}
