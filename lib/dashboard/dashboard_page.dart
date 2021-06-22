import 'package:discord_ui_clone/Widget/scroll_bottom_navigation_bar.dart';
import 'package:discord_ui_clone/screens/left_screen.dart';
import 'package:discord_ui_clone/screens/right_screen.dart';
import 'package:discord_ui_clone/screens/center_screen.dart';
import 'package:discord_ui_clone/other/InnerDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  final _key = GlobalKey<InnerDrawerState>();
  final leftKey = GlobalKey<ScrollBottomNavigationBarState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: InnerDrawer(
            key: _key,
            leftChild: LeftScreen(innerDrawerKey: _key),
            rightChild: RightScreen(innerDrawerKey: _key),
            scaffold: CenterScreen(innerDrawerKey: _key),
            innerDrawerCallback: callback,
          ),
          bottomNavigationBar: ScrollBottomNavigationBar(
            key: leftKey,
            items: [
              _bottomNavigationBarItem(
                icon: CupertinoIcons.home,
                label: 'Home',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.sportscourt,
                label: 'News',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.person,
                label: 'Account',
              ),
            ],
          ),
        );
      },
    );
  }

  void callback(int status) {
    if (status == 1) {
      leftKey.currentState.show();
    } else if (status == 0) {
      leftKey.currentState.hide();
    }
  }

  _bottomNavigationBarItem({IconData icon, String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
