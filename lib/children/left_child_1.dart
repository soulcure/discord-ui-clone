import 'dart:ui';
import 'package:discord_ui_clone/Widget/scroll_bottom_navigation_bar.dart';
import 'package:discord_ui_clone/notifier/drawer_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeftChild extends StatefulWidget {
  LeftChild({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LeftChildState();
  }
}

class _LeftChildState extends State<LeftChild> {
  GlobalKey<ScrollBottomNavigationBarState> leftKey = GlobalKey();

  static const _items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Page 1",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Page 2",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.mail),
      label: "Page 3",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    print("build left");
    final double swipeOffset =
        context.select((DrawerNotifier value) => value.swipeOffset);

    final double height = MediaQuery.of(context).size.height;
    final bodyHeight = height -
        kMinInteractiveDimension -
        kToolbarHeight -
        kBottomNavigationBarHeight;

    return Scaffold(
      appBar: AppBar(title: Text("Simple scroll")),
      body: Container(
        constraints: BoxConstraints(
          maxHeight: bodyHeight,
        ),
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
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10, bottom: 15),
                        width: 80,
                        child: ClipRRect(
                          child: Image.network(
                            "https://img.icons8.com/officel/2x/user.png",
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      Text(
                        "User",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                    //mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  ListTile(
                    onTap: () => print("Dashboard"),
                    title: Text(
                      "Dashboard",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    leading: Icon(
                      Icons.dashboard,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Nametag",
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Icon(
                      Icons.rounded_corner,
                      size: 22,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Favorite",
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Icon(
                      Icons.bookmark_border,
                      size: 22,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Close Friends",
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Icon(
                      Icons.list,
                      size: 22,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Suggested People",
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: Icon(
                      Icons.person_add,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      child: new Text('show'),
                      onPressed: () {
                        leftKey.currentState.show();
                      },
                    ),
                    MaterialButton(
                      child: new Text('hide'),
                      onPressed: () {
                        leftKey.currentState.hide();
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: ScrollBottomNavigationBar(
        key: leftKey,
        items: _items,
      ),
    );
  }
}
