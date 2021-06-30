import 'package:discord_ui_clone/screens/chat_view.dart';
import 'package:discord_ui_clone/widgets/inner_drawer.dart';
import 'package:flutter/material.dart';

class CenterScreen extends StatelessWidget {
  final GlobalKey<InnerDrawerState> innerDrawerKey;

  CenterScreen({this.innerDrawerKey, Key key}) : super(key: key);

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
