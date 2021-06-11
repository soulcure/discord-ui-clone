import 'package:discord_ui_clone/notifier/drawer_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/InnerDrawer.dart';

class ScaffoldDrawer extends StatelessWidget {
  final GlobalKey<InnerDrawerState> innerDrawerKey;

  ScaffoldDrawer({this.innerDrawerKey, Key key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    print("ScaffoldDrawer");

    final drawer = Provider.of<DrawerNotifier>(context, listen: true);

    return Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.green),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(100),
              ),
              Text(
                "Animation Type",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text('Offset'),
              Text(drawer.offset.toString()),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "Set Color Transition",
                style: TextStyle(
                    color: drawer.colorTransition, fontWeight: FontWeight.w500),
              ),
              Padding(padding: EdgeInsets.all(25)),
              ElevatedButton(
                child: Text("open"),
                onPressed: () {
                  // direction is optional
                  // if not set, the last direction will be used
                  innerDrawerKey.currentState.open();
                },
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
        ));
  }
}
