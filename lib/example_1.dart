import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/InnerDrawer.dart';
import 'children/left_child_1.dart';
import 'notifier/drawer_notifier.dart';
import 'children/right_child_1.dart';
import 'scaffolds/scaffolds_1.dart';

class ExampleOne extends StatelessWidget {
  final _key = GlobalKey<InnerDrawerState>();

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: _key,
      onTapClose: context.select((DrawerNotifier value) => value.onTapToClose),
      tapScaffoldEnabled:
          context.select((DrawerNotifier value) => value.tapScaffold),
      velocity: 20,

      leftChild: LeftChild(),

      rightChild: RightChild(innerDrawerKey: _key),

      scaffold: ScaffoldDrawer(innerDrawerKey: _key),
      //innerDrawerCallback: (a) => print(a),
    );
  }
}
