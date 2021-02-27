import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakoon/components/default_button.dart';
import 'package:sakoon/data/constants.dart';
import 'package:sakoon/navigators/bottom_nav_bar.dart';
import 'package:sakoon/screens/home/home_screen.dart';
import 'package:geolocator/geolocator.dart';
class HomeMaintanance extends StatefulWidget {
  static String routeName = "/home_maintainance";
  @override
  _HomeMaintananceState createState() => _HomeMaintananceState();
}

class _HomeMaintananceState extends State<HomeMaintanance> {
  Position _currentPosition;
  String _currentAddress;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  bool _isWoodChecked=false;
  bool _isAluminiumChecked=false;
  bool _isGlassChecked=false;
  bool _isPlasterChecked=false;
  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print(_currentAddress);
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }
  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child:
              Container(
                alignment: Alignment.center,
                child: Text("Please select the work",textAlign: TextAlign.center,style: TextStyle(color: kPrimaryColor,fontSize: 25,fontWeight: FontWeight.w600)),
              ),
            ),
       SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('This is a demo alert dialog.'),
            Text('Would you like to approve of this message?'),
          ],
        ),
      ),
            Expanded(
              flex: 8,
              child: ListView(
                children: [

                  CheckboxListTile(
                      title: Text("Wood"),
                      value: _isWoodChecked,
                      activeColor: kPrimaryColor,
                      onChanged: (bool value){
                        setState(() {
                          _isWoodChecked=value;
                        });
                      }
                  ),
                  CheckboxListTile(
                      title: Text("Plaster of Paris"),
                      value: _isPlasterChecked,
                      activeColor: kPrimaryColor,
                      onChanged: (bool value){
                        setState(() {
                          _isPlasterChecked=value;
                        });
                      }
                  ),
                  CheckboxListTile(
                      title: Text("Aluminium"),
                      value: _isAluminiumChecked,
                      activeColor: kPrimaryColor,
                      onChanged: (bool value){
                        setState(() {
                          _isAluminiumChecked=value;
                        });
                      }
                  ),
                  CheckboxListTile(
                      title: Text("Glass"),
                      value: _isGlassChecked,
                      activeColor: kPrimaryColor,
                      onChanged: (bool value){
                        setState(() {
                          _isGlassChecked=value;
                        });
                      }
                  ),

                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: DefaultButton(
                  text: "Submit",
                  press: () {
                    _getCurrentLocation();
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                ),
                margin: EdgeInsets.only(left: 40,right: 40,bottom: 15),
              ),
            )
          ],
        ),
      )

    );
  }
}
