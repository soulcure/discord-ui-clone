import 'dart:ui';
import 'package:flutter/material.dart';

import '../Screens/InnerDrawer.dart';

class RightChild extends StatelessWidget {
  final GlobalKey<InnerDrawerState> innerDrawerKey;
  RightChild({this.innerDrawerKey, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build right");

    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              ListTile(
                title: Text("Statistics"),
                leading: Icon(Icons.show_chart),
              ),
              ListTile(
                title: Text("Activity"),
                leading: Icon(Icons.access_time),
              ),
              ListTile(
                title: Text("Nametag"),
                leading: Icon(Icons.rounded_corner),
              ),
              ListTile(
                title: Text("Favorite"),
                leading: Icon(Icons.bookmark_border),
              ),
              ListTile(
                title: Text("Close Friends"),
                leading: Icon(Icons.list),
              ),
              ListTile(
                title: Text("Suggested People"),
                leading: Icon(Icons.person_add),
              ),
              ElevatedButton(
                child: Text("close"),
                onPressed: () {
                  // direction is optional
                  // if not set, the last direction will be used
                  innerDrawerKey.currentState.close();
                },
              ),
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                //width: double.maxFinite,
                decoration: BoxDecoration(
                    //color: Colors.grey,
                    border: Border(
                        top: BorderSide(
                  color: Colors.grey[300],
                ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.settings,
                      size: 18,
                    ),
                    Text(
                      "Settings",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
