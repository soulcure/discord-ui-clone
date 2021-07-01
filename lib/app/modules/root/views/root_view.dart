import 'package:discord_ui_clone/app/modules/root/controllers/root_controller.dart';
import 'package:discord_ui_clone/screens/left_screen.dart';
import 'package:discord_ui_clone/screens/right_screen.dart';
import 'package:discord_ui_clone/screens/center_screen.dart';
import 'package:discord_ui_clone/widgets/inner_drawer.dart';
import 'package:discord_ui_clone/widgets/scroll_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootView extends GetView<RootController> {
  final _scrollNavKey = GlobalKey<ScrollBottomNavigationBarState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(
      builder: (controller) {
        return Scaffold(
          body: InnerDrawer(
            leftChild: LeftScreen(),
            rightChild: RightScreen(),
            scaffold: CenterScreen(),
            innerDrawerCallback: callback,
          ),
          bottomNavigationBar: ScrollBottomNavigationBar(
            key: _scrollNavKey,
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
      _scrollNavKey.currentState.show();
    } else if (status == 0) {
      _scrollNavKey.currentState.hide();
    }
  }

  _bottomNavigationBarItem({IconData icon, String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
