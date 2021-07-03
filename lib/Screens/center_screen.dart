import 'package:discord_ui_clone/screens/chat_view.dart';
import 'package:flutter/material.dart';

class CenterScreen extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    print("CenterScreen build");

    return Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0))),
      child: Center(
        child: Column(
          children: <Widget>[
            Text("111"),
            Text("111"),
            Text("111"),
            Expanded(
              child: ScrollablePositionedListPage(),
            ),
          ],
        ),
      ),
    );
  }
}
