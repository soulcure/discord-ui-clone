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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _key = GlobalKey<InnerDrawerState>();

  LeftChild leftChild;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    leftChild = LeftChild(innerDrawerKey: _key);
    return MaterialApp(
        title: 'Inner Drawer',
        theme: ThemeData(
            primaryColor: Color(0xFF075E54), accentColor: Color(0xFF128C7E)),
        home: Scaffold(
          body: InnerDrawer(
            key: _key,
            leftChild: leftChild,
            rightChild: RightChild(innerDrawerKey: _key),
            scaffold: ScaffoldDrawer(innerDrawerKey: _key),
            innerDrawerCallback: callback,
          ),
        ));
  }

  void callback(bool left, bool open) {
    print("yao drawer callback left=$left open=$open");
    if (left && open) {
      leftChild.show();
    } else if (left && !open) {
      leftChild.hide();
    }
  }
}
