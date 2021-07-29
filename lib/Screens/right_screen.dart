import 'dart:ui';
import 'package:discord_ui_clone/utils/event_bus.dart';
import 'package:flutter/material.dart';

class RightScreen extends StatelessWidget {
  const RightScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build right');

    return Container(
      decoration: const BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0))),
      child: ListView(
        children: <Widget>[
          const ListTile(
            title: Text('Statistics'),
            leading: Icon(Icons.show_chart),
          ),
          const ListTile(
            title: Text('Activity'),
            leading: Icon(Icons.access_time),
          ),
          const ListTile(
            title: Text('Nametag'),
            leading: Icon(Icons.rounded_corner),
          ),
          const ListTile(
            title: Text('Favorite'),
            leading: Icon(Icons.bookmark_border),
          ),
          const ListTile(
            title: Text('Close Friends'),
            leading: Icon(Icons.list),
          ),
          const ListTile(
            title: Text('Suggested People'),
            leading: Icon(Icons.person_add),
          ),
          ElevatedButton(
            child: const Text('close'),
            onPressed: () {
              Event.eventBus.fire(InnerDrawerStatus(0));
            },
          ),
          Container(
            alignment: Alignment.bottomLeft,
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            //width: double.maxFinite,
            decoration: BoxDecoration(
                //color: Colors.grey,
                border: Border(
                    top: BorderSide(
              color: Colors.grey[300],
            ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Icon(
                  Icons.settings,
                  size: 18,
                ),
                Text(
                  'Settings',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
