import 'package:discord_ui_clone/account/account_page.dart';
import 'package:discord_ui_clone/app/modules/root/controllers/home_controller.dart';
import 'package:discord_ui_clone/news/news_page.dart';
import 'package:discord_ui_clone/screens/left_screen.dart';
import 'package:discord_ui_clone/screens/right_screen.dart';
import 'package:discord_ui_clone/screens/center_screen.dart';
import 'package:discord_ui_clone/widgets/inner_drawer.dart';
import 'package:discord_ui_clone/widgets/scroll_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                InnerDrawer(
                  leftChild: LeftScreen(),
                  rightChild: RightScreen(),
                  scaffold: CenterScreen(),
                ),
                NewsPage(),
                AccountPage(),
              ],
            ),
          ),
          bottomNavigationBar: ScrollBottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.redAccent,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
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

  _bottomNavigationBarItem({IconData icon, String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
