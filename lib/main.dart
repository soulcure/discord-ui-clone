import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/InnerDrawer.dart';
import 'children/left_child_1.dart';
import 'children/right_child_1.dart';
import 'notifier/drawer_notifier.dart';
import 'scaffolds/scaffolds_1.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (context) => DrawerNotifier(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  final _key = GlobalKey<InnerDrawerState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inner Drawer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
      ),
      home: Scaffold(
          body: SafeArea(
        // 加入SafeArea
        child: InnerDrawer(
          key: _key,
          leftChild: LeftChild(innerDrawerKey: _key),
          rightChild: RightChild(innerDrawerKey: _key),
          scaffold: ScaffoldDrawer(innerDrawerKey: _key),
          //innerDrawerCallback: (a) => print(a),
        ),
      )),
    );
  }
}
