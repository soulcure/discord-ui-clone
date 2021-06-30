import 'dart:ui';
import 'package:discord_ui_clone/widgets/inner_drawer.dart';
import 'package:flutter/material.dart';

class LeftScreen extends StatelessWidget {
  ///InnerDrawer widget globalKey
  final GlobalKey<InnerDrawerState> innerDrawerKey;

  LeftScreen({this.innerDrawerKey, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build left");

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.red),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(50),
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
            ElevatedButton(
              child: Text("socroll to 100"),
              onPressed: () {
                // direction is optional
                // if not set, the last direction will be used
                innerDrawerKey.currentState.close();
              },
            ),
            ElevatedButton(
              child: Text("socroll to 500"),
              onPressed: () {
                // direction is optional
                // if not set, the last direction will be used
                innerDrawerKey.currentState.close();
              },
            ),
            ElevatedButton(
              child: Text("jump to 100"),
              onPressed: () {
                // direction is optional
                // if not set, the last direction will be used
                innerDrawerKey.currentState.close();
              },
            ),
            ElevatedButton(
              child: Text("jump to 500"),
              onPressed: () {
                // direction is optional
                // if not set, the last direction will be used
                innerDrawerKey.currentState.close();
              },
            ),
          ],
        ),
      ),
    );
  }
}
