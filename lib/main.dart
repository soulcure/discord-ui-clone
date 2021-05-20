import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'example_1.dart';
import 'notifier/drawer_notifier.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (context) => DrawerNotifier(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inner Drawer',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        backgroundColor: Colors.white,
      ),
      home: MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  MainApp({Key key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      // 加入SafeArea
      child: ExampleOne(),
    ));
  }
}
