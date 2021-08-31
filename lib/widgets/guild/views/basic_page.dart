import 'package:discord_ui_clone/widgets/scroll/scroll_flexible_widget.dart';
import 'package:flutter/material.dart';

class BasicPage extends StatelessWidget {
  BasicPage({Key key}) : super(key: key);

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic"),
      ),
      body: Column(
        children: [
          ScrollFlexibleWidget(
            controller: controller,
            flexibleSpace: Container(
                height: 200,
                width: double.infinity,
                color: Colors.blue[500],
                child: const Center(child: Text("test"))),
          ),
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemBuilder: (context, index) {
                return Text("index $index");
              }, // Controller is also here
            ),
          )
        ],
      ),
    );
  }
}
