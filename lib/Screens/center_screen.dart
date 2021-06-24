import 'package:discord_ui_clone/widgets/inner_drawer.dart';
import 'package:flutter/material.dart';

class CenterScreen extends StatelessWidget {
  final GlobalKey<InnerDrawerState> innerDrawerKey;

  CenterScreen({this.innerDrawerKey, Key key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    print("ScaffoldDrawer");

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
                padding: EdgeInsets.all(150),
              ),
              ElevatedButton(
                child: Text("open left"),
                onPressed: () {
                  // direction is optional
                  // if not set, the last direction will be used
                  innerDrawerKey.currentState.openLeft();
                },
              ),
              ElevatedButton(
                child: Text("open right"),
                onPressed: () {
                  // direction is optional
                  // if not set, the last direction will be used
                  innerDrawerKey.currentState.openRight();
                },
              ),
            ],
          ),
        ));
  }
}
