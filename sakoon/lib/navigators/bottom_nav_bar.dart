import 'package:flutter/material.dart';
import 'package:sakoon/data/constants.dart';
import 'package:sakoon/screens/botton_nav/homePage.dart';

class Home extends StatefulWidget {


  @override
  _BottomNavigationBarControllerState createState() => _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState extends State<Home> {

  //ScrollController _scrollController;
  List<Widget> pages;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    pages = [
      HomePage(),
      Center(child: Text("Projects"),),
      Center(child: Text("About"),),
      Center(child: Text("Partners"),),

    ];
  }

  @override
  void dispose() {
    //_scrollController.dispose();
    super.dispose();
  }


  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
    showUnselectedLabels: true,

    selectedItemColor: kPrimaryColor,
    unselectedItemColor: Colors.grey,
    onTap: (int index) {
      setState(() {
        _selectedIndex = index;
      });
    },
    currentIndex: selectedIndex,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.home), title: Text('Home')),
      BottomNavigationBarItem(
          icon: Icon(Icons.work), title: Text('Project')),
      BottomNavigationBarItem(
          icon: Icon(Icons.person), title: Text('About')),
      BottomNavigationBarItem(
          icon: Icon(Icons.people), title: Text('Partners')),

    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),

    );
  }
}