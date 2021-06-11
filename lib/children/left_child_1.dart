import 'dart:ui';
import 'package:discord_ui_clone/Widget/scroll_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../Screens/InnerDrawer.dart';

class LeftChild extends StatelessWidget {
  final GlobalKey<InnerDrawerState> innerDrawerKey;
  LeftChild({this.innerDrawerKey, Key key}) : super(key: key);

  final leftKey = GlobalKey<ScrollBottomNavigationBarState>();

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

  show() {
    leftKey.currentState.show();
  }

  hide() {
    leftKey.currentState.hide();
  }

  @override
  Widget build(BuildContext context) {
    print("build left");
    final height = MediaQuery.of(context).size.height;

    final top = MediaQueryData.fromWindow(window).padding.top;
    final bodyHeight = height - top - kBottomNavigationBarHeight;

    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
          maxHeight: bodyHeight,
        ),
        decoration: BoxDecoration(color: Colors.red),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                  ElevatedButton(
                    child: Text("close"),
                    onPressed: () {
                      // direction is optional
                      // if not set, the last direction will be used
                      innerDrawerKey.currentState.close();
                    },
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
