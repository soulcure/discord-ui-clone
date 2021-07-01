import 'package:discord_ui_clone/screens/chat_view.dart';
import 'package:flutter/material.dart';

class CenterScreen extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    print("CenterScreen build");

    return Scaffold(
      appBar: AppBar(
        title: Text("chat view"),
      ),
      body: ScrollablePositionedListPage(),
    );
  }
}
