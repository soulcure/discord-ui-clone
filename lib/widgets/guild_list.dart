import 'package:flutter/widgets.dart';

class GuildListView extends StatefulWidget {
  GuildListView({Key key}) : super(key: key);

  @override
  _GuildListViewState createState() => _GuildListViewState();
}

class _GuildListViewState extends State<GuildListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) {
            return Text("index $index");
          }),
    );
  }
}
