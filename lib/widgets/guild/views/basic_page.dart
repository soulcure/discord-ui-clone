import 'package:discord_ui_clone/widgets/scroll/scroll_flexible_widget.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class BasicPage extends StatelessWidget {
  BasicPage({Key key}) : super(key: key);

  final controller = ScrollController();

  final ItemScrollController itemScrollController = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic"),
      ),
      body: Column(
        children: [
          ScrollFlexibleWidget(
            controller: itemScrollController.scrollController,
            flexibleSpace: Container(
                height: 200,
                width: double.infinity,
                color: Colors.blue[500],
                child: const Center(child: Text("test"))),
          ),
          Expanded(
            child: list(Orientation.portrait),
          )
        ],
      ),
    );
  }

  Widget list(Orientation orientation) => ScrollablePositionedList.builder(
        itemCount: 500,
        itemBuilder: (context, index) => item(index, orientation),
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        scrollDirection: orientation == Orientation.portrait
            ? Axis.vertical
            : Axis.horizontal,
      );

  /// Generate item number [i].
  Widget item(int i, Orientation orientation) {
    //debugPrint("yao build listview index=$i");
    return SizedBox(
      height: 30,
      width: 300,
      child: Container(
        child: Center(
          child: Text('Item $i'),
        ),
      ),
    );
  }
}
