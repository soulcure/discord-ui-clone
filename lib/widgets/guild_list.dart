import 'package:flutter/widgets.dart';

class GuildListViewController extends StatefulWidget {
  GuildListViewController({Key key}) : super(key: key);

  @override
  _GuildListViewControllerState createState() =>
      _GuildListViewControllerState();
}

class _GuildListViewControllerState extends State<GuildListViewController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(itemBuilder: itemBuilder),
    );
  }
}
