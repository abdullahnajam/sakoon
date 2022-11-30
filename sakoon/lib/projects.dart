import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sakoon/model/projects.dart';

import 'data/constants.dart';
import 'navigators/menu_drawer.dart';
class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final PageController pageController=PageController(initialPage: 0);
  List<ProjectModel> piclist=[];
  Future<List<ProjectModel>> getPartnersList() async {
    List<ProjectModel> list=[];
    final ref = FirebaseDatabase.instance.ref("projects");
    DatabaseEvent event = await ref.once();
    if(event.snapshot.value!=null){
      Map<dynamic, dynamic> values = event.snapshot.value;
      values.forEach((key, values) {
        ProjectModel projectModel=ProjectModel(
          key,
          values['url'],
          values['name'],
        );
        list.add(projectModel);
        piclist.add(projectModel);
      });
    }

    return list;
  }

  openImage(){
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(piclist[index].url),
                );
              },
              itemCount: piclist.length,
              loadingBuilder: (context, progress) => Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                  ),
                ),
              ),
              pageController: pageController,
            );
          },
        );
      },
    );
  }

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  void _openDrawer () {
    _drawerKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                      child: Text("Projects",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 13),),
                    ),


                  ],
                ),
              ),

              Expanded(
                child: FutureBuilder<List<ProjectModel>>(
                  future: getPartnersList(),
                  builder: (context,snapshot){
                    if (snapshot.hasData) {
                      if (snapshot.data != null && snapshot.data.length>0) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  openImage();
                                },
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
