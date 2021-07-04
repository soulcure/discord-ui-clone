import 'package:discord_ui_clone/screens/chat_view.dart';
import 'package:flutter/material.dart';

class CenterScreen extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    print("CenterScreen build");

    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
      child: Scaffold(
        appBar: AppBar(
          title: Text("chat demo"),
          leading: Icon(
            Icons.menu,
            color: Colors.white,
            size: 27,
          ),
        ),
        body: ScrollablePositionedListPage(),
      ),
    );
  }
}
