import 'dart:ui';
import 'package:discord_ui_clone/Screens/InnerDrawer.dart';
import 'package:discord_ui_clone/notifier/drawer_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RightChild extends StatelessWidget {
  final bool _position = true;
  final GlobalKey<InnerDrawerState> innerDrawerKey;
  RightChild({this.innerDrawerKey, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build right");
    final double swipeOffset =
        context.select((DrawerNotifier value) => value.swipeOffset);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          //stops: [0.1, 0.5,0.5, 0.7, 0.9],
          colors: [
            ColorTween(
              begin: Colors.blueAccent,
              end: Colors.blueGrey[400].withRed(100),
            ).lerp(swipeOffset),
            ColorTween(
              begin: Colors.green,
              end: Colors.blueGrey[800].withGreen(80),
            ).lerp(swipeOffset),
          ],
        ),
      ),
      child: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 4, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 15,
                            height: 15,
                            child: CircleAvatar(
                              child: Icon(Icons.person,
                                  color: Colors.white, size: 12),
                              backgroundColor: Colors.grey,
                            ),
                          ),
                          Text(
                            "   Guest",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, height: 1.2),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2, right: 25),
                        child: GestureDetector(
                          child: Icon(
                            _position ? Icons.arrow_back : Icons.arrow_forward,
                            size: 18,
                          ),
                          onTap: () {
                            innerDrawerKey.currentState.toggle();
                          },
                        ),
                      ),
                    ],
                  )),
              Divider(),
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
              ListTile(
                title: Text("Open Facebook"),
                leading: Icon(Icons.ac_unit),
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
                      "  Settings",
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
