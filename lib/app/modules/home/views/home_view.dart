import 'package:discord_ui_clone/account/account_page.dart';
import 'package:discord_ui_clone/app/modules/home/controllers/home_controller.dart';
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
                  rightChild: const RightScreen(),
                  scaffold: CenterScreen(),
                ),
                NewsPage(),
                AccountPage(),
              ],
            ),
          ),
          bottomNavigationBar: ScrollBottomNavigationBar(
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            unselectedItemColor: Colors.white70,
            selectedItemColor: Colors.white,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black54,
            items: [
              _bottomNavigationBarItem(
                icon: Icons.home,
                label: 'Home',
              ),
              _bottomNavigationBarItem(
                icon: Icons.favorite,
                label: 'News',
              ),
              _bottomNavigationBarItem(
                icon: Icons.search,
                label: 'Account',
              ),
              _bottomNavigationBarItem(
                icon: Icons.attach_email,
                label: 'Account',
              ),
              _bottomNavigationBarItem(
                icon: Icons.settings,
                label: 'settings',
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
