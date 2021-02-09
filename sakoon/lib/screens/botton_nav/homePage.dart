import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakoon/components/default_button.dart';

class HomePage extends StatefulWidget {

@override
_HomePageState createState() => new _HomePageState();
}


class _HomePageState extends State<HomePage> {
  PageController _controller = PageController(
    initialPage: 0,
  );


  @override
  void initState() {
    super.initState();

  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        return Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              Container(
                height: 250,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 225,
                      child: PageView.builder(
                        itemBuilder: (context, position) {
                          return Container(
                              padding: EdgeInsets.only(bottom: 50),
                              height: 225,
                              decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage("http://i.imgur.com/HmjQ2tj.jpg")
                                  )
                              ),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,

                              child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text('    Ad title here',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(color: Colors.black,
                                            fontSize: 27,
                                            fontWeight: FontWeight.w600),),

                                    ],
                                  )
                              )

                          );
                        },
                        itemCount: 3, // Can be null
                      )
                    ),


                    Card(

                      margin: EdgeInsets.only(top: 200, left: 20, right: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius
                          .circular(25),),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 1,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.search, color: Colors.grey[600]),
                              onPressed: () {

                              }),
                          Expanded(
                            child: Text("Search",style: TextStyle(
                                color: Colors.grey[600], fontSize: 18),)
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 30,),
              Container(
                margin: EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultButton(
                      text: "Fresh Work",
                      press: () {

                      },
                    ),
                    SizedBox(height: 30,),
                    DefaultButton(
                      text: "Maintaince",
                      press: () {

                      },
                    ),
                    SizedBox(height: 30,),
                    DefaultButton(
                      text: "Home Appliances",
                      press: () {

                      },
                    ),
                    SizedBox(height: 30,),
                  ],
                ),
              )


            ],
          ),
        );
      }),
    );
  }
}

