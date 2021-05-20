import 'package:discord_ui_clone/Screens/InnerDrawer.dart';
import 'package:discord_ui_clone/notifier/drawer_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class ScaffoldDrawer extends StatelessWidget {
  Color pickerColor;
  final GlobalKey<InnerDrawerState> innerDrawerKey;

  ScaffoldDrawer({this.innerDrawerKey});

  @override
  Widget build(BuildContext context) {
    print("scaffold 1");

    final drawer = Provider.of<DrawerNotifier>(context, listen: true);
    pickerColor = drawer.colorTransition;

    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              ColorTween(
                begin: Colors.blueAccent,
                end: Colors.blueGrey[400].withRed(100),
              ).lerp(drawer.swipeOffset),
              ColorTween(
                begin: Colors.green,
                end: Colors.blueGrey[800].withGreen(80),
              ).lerp(drawer.swipeOffset),
            ],
          ),
        ),
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
              TextButton(
                child: Text(
                  "Set Color Transition",
                  style: TextStyle(
                      color: drawer.colorTransition,
                      fontWeight: FontWeight.w500),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Pick a color!'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: drawer.colorTransition,
                            onColorChanged: (Color color) =>
                                pickerColor = color,
                            //enableLabel: true,
                            pickerAreaHeightPercent: 0.8,
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Set'),
                            onPressed: () {
                              drawer.setColorTransition(pickerColor);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              Padding(padding: EdgeInsets.all(25)),
              ElevatedButton(
                child: Text("open"),
                onPressed: () {
                  // direction is optional
                  // if not set, the last direction will be used
                  innerDrawerKey.currentState.toggle();
                },
              ),
            ],
          ),
        ));
  }
}
